import 'package:auth/domain/usecases/refresh_user_usecase.dart';
import 'package:auth/presentation/controller/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshUserCubit extends Cubit<AuthState> {
  RefreshUserCubit(this.refreshUserUsecase) : super(AuthInitial());

  final RefreshUserUsecase refreshUserUsecase;

  void refreshUser({required User user}) async {
    emit(AuthLoadingState());
    try {
      User? refreshUser = await refreshUserUsecase.execute(user: user);
      if (refreshUser != null) {
        emit(AuthAuthenticatedState(refreshUser));
      } else {
        emit(AuthErrorState('User not found'));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
