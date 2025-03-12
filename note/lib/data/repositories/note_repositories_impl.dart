import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:note/domain/repositories/note_repositories.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class NoteRepositoriesImpl implements NoteRepositories {
  // static String? userUID = 'd0aNjeNVBKqWGK6oRul7';

  Future<String?> _getUserUID() async {
    return await UserStorage.getUserUID(); // Fetch the UID from SharedPreferences
  }

  @override
  Future<void> addNote(String title, String description) async {
    DocumentReference documentReference =
        _mainCollection.doc(await _getUserUID()).collection('items').doc();

    Map<String, dynamic> data = {"title": title, "description": description};

    await documentReference
        .set(data)
        .whenComplete(() => debugPrint('Note added in Firebase'))
        .catchError((e) => debugPrint(e));
  }

  @override
  Future<void> deleteNote(String docId) async {
    DocumentReference documentReference = _mainCollection
        .doc(await _getUserUID())
        .collection('items')
        .doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => debugPrint('Note delete in Firebase'))
        .catchError((e) => debugPrint(e));

    // DocumentReference documentReferencer = _firestore
    //     .collection('notes')
    //     .doc(userUid)
    //     .collection('items')
    //     .doc(docId);
  }

  @override
  Future<void> updateNote(
    String title,
    String description,
    String docId,
  ) async {
    DocumentReference documentReference = _mainCollection
        .doc(await _getUserUID())
        .collection('items')
        .doc(docId);

    Map<String, dynamic> data = {"title": title, "description": description};

    await documentReference
        .update(data)
        .whenComplete(() => debugPrint('Note updated in Firebase'))
        .catchError((e) => debugPrint(e));

    // DocumentReference documentReferencer = _firestore
    //     .collection('notes')
    //     .doc(userUid)
    //     .collection('items')
    //     .doc(docId);
  }

  @override
  Stream<QuerySnapshot> getNotes() async* {
    if (await _getUserUID() == null) {
      debugPrint('No user UID found!');
      yield* Stream.empty();
      return;
    }
    CollectionReference noteItemCollection = _mainCollection
        .doc(await _getUserUID())
        .collection('items');
    yield* noteItemCollection.snapshots();
  }
}
