import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:qent/features/auth/data/models/sign_up_request_params.dart';
import 'package:qent/features/auth/domain/repository/auth_repo.dart';
import 'package:qent/features/auth/presentation/cubit/auth_state.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AuthCubit(this._authRepo) : super(const AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    final result = await _authRepo.login(email, password);
    result.when(
      (failure) => emit(AuthError(failure)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> signUp(SignUpRequestParams params) async {
    emit(const AuthLoading());
    final result = await _authRepo.signUp(params);
    result.when(
      (failure) => emit(AuthError(failure)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> sendVerifyCode(String method, {required bool isPhone}) async {
    emit(const SendVerifyCodeLoading());
    final result = await _authRepo.sendVerifyCode(method, isPhone: isPhone);
    result.when(
      (failure) => emit(SendVerifyCodeError(failure)),
      (verifyToken) => emit(SendVerifyCodeSuccess(verifyToken)),
    );
  }

  Future<void> confirmPhoneCode(String token, String code) async {
    emit(const ConfirmCodeLoading());
    final result = await _authRepo.confirmPhoneCode(token, code);
    result.when(
      (failure) => emit(ConfirmCodeError(failure)),
      (_) => emit(const ConfirmCodeSuccess()),
    );
  }
}
