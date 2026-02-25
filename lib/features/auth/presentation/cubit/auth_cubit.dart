import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:qent/features/auth/data/params/reset_password_request_params.dart';
import 'package:qent/features/auth/data/params/sign_up_request_params.dart';
import 'package:qent/features/auth/domain/repository/auth_repo.dart';
import 'package:qent/features/auth/presentation/cubit/auth_state.dart';
import 'package:qent/generated/l10n.dart';

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
      (codeEntity) => emit(SendVerifyCodeSuccess(codeEntity)),
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

  Future<void> confirmEmailCode({
    required String code,
    required String codeConfirm,
  }) async {
    emit(const ConfirmCodeLoading());
    await Future.delayed(const Duration(seconds: 2));
    if (code == codeConfirm) {
      emit(const ConfirmCodeSuccess());
    } else {
      emit(ConfirmCodeError(S.current.invalidCode));
    }
  }

  Future<void> resetPassword(ResetPasswordRequestParams params) async {
    emit(const ResetPasswordLoading());
    final result = await _authRepo.resetPassword(params);
    result.when(
      (failure) => emit(ResetPasswordError(failure)),
      (_) => emit(const ResetPasswordSuccess()),
    );
  }
}
