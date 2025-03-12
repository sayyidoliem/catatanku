import 'package:auth/domain/usecases/sign_in_email_password_user_usecase.dart';
import 'package:auth/presentation/controller/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInEmailPasswordUserCubit extends Cubit<AuthState> {
  SignInEmailPasswordUserCubit(this.signInEmailPasswordUserUsecase)
    : super(AuthInitial());

  final SignInEmailPasswordUserUsecase signInEmailPasswordUserUsecase;

  void signInEmailPasswordUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoadingState());
    try {
      final user = await signInEmailPasswordUserUsecase.execute(
        email: email,
        password: password,
        context: context,
      );
      if (user != null) {
        emit(AuthAuthenticatedState(user));
      } else {
        emit(AuthErrorState("Authentication failed.")); // Emit failure state
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to sign in: $e")));
    }
  }
}
