import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthRepositories {
  Future<void> addUserUID();

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  );

  Future<User?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
    BuildContext context,
  );

  Future<User?> refreshUser(User user);
}
