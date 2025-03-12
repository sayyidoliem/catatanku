import 'package:auth/domain/repositories/auth_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterEmailPasswordUserUsecase {
  final AuthRepositories repository;

  RegisterEmailPasswordUserUsecase(this.repository);

  Future<User?> execute({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    return repository.registerWithEmailAndPassword(
      name,
      email,
      password,
      context,
    );
  }
}
