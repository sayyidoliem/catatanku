import 'package:auth/domain/usecases/register_email_password_user_usecase.dart';
import 'package:auth/presentation/controller/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterEmailPasswordUserCubit extends Cubit<AuthState> {
  RegisterEmailPasswordUserCubit(this.registerEmailPasswordUserUsecase)
    : super(AuthInitial());

  final RegisterEmailPasswordUserUsecase registerEmailPasswordUserUsecase;

  void registerEmailPasswordUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoadingState());
    try {
      final user = await registerEmailPasswordUserUsecase.execute(
        name: name,
        email: email,
        password: password,
        context: context,
      );
      if (user != null) {
        emit(AuthAuthenticatedState(user));
      } else {
        emit(AuthErrorState("Registration failed."));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to register: $e")));
    }
  }
}
