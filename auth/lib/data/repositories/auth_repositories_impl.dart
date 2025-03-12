import 'package:auth/domain/repositories/auth_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class AuthRepositoriesImpl implements AuthRepositories {
  @override
  Future<User?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    User? user;

    try {
      // Register the user with Firebase Authentication
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;

      if (user != null) {
        // Store user information in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'name': name,
          'uid': user.uid,
        });

        // Update user display name and reload the user data
        await user.updateDisplayName(name);
        await user.reload();
        user = _firebaseAuth.currentUser;

        // Call addUserUID() to ensure the UID is saved in the notes collection
        await addUserUID();
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = e.message ?? 'An unexpected error occurred.';
      }
      debugPrint(errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }

    return user;
  }

  @override
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    User? user;

    try {
      // Sign in the user with Firebase Authentication
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;

      if (user != null) {
        // Optionally update Firestore data
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
        }, SetOptions(merge: true)); // Merge allows partial updates

        // Call addUserUID() to ensure the UID is saved in the notes collection
        await addUserUID();
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email. Please create an account.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = e.message ?? 'An unexpected error occurred.';
      }
      debugPrint(errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }

    return user;
  }

  @override
  Future<void> addUserUID() async {
    User? user = _firebaseAuth.currentUser;

    if (user == null) {
      debugPrint("No user is authenticated. Handle this case.");
      return;
    }

    String currentUserUID = user.uid;

    // Check if the UID is already stored in the Firestore collection
    DocumentReference userDoc = _mainCollection.doc(currentUserUID);

    bool userExists = await userDoc.get().then((doc) => doc.exists);

    // If UID doesn't exist, create the document in Firestore
    if (!userExists) {
      try {
        await userDoc.set({
          'uid': currentUserUID,
          'createdAt': FieldValue.serverTimestamp(),
        }).then((_) {
          debugPrint("User UID created and stored in Firestore.");
        }).catchError((e) {
          debugPrint("Failed to create user UID in Firestore: $e");
        });
      } catch (e) {
        debugPrint("Error creating User UID: $e");
      }
    }
  }

  @override
  Future<User?> refreshUser(User user) {
    // TODO: implement refreshUser
    throw UnimplementedError();
  }
}
