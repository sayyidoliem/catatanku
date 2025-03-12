import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

// class AuthSignInEmailPasswordState extends AuthState {}

// class AuthRegisterEmailPasswordState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final User user;

  const AuthAuthenticatedState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState(this.message);
}
