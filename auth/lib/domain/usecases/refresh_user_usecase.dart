import 'package:auth/domain/repositories/auth_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RefreshUserUsecase {
  final AuthRepositories repository;

  RefreshUserUsecase(this.repository);

  Future<User?> execute({required User user}) async {
    return repository.refreshUser(user);
  }
}
