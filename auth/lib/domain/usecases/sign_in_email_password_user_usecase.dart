import 'package:auth/domain/repositories/auth_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInEmailPasswordUserUsecase {
  final AuthRepositories authRepository;

  SignInEmailPasswordUserUsecase(this.authRepository);

  Future<User?> execute({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    return authRepository.signInWithEmailAndPassword(email, password, context);
  }
}
