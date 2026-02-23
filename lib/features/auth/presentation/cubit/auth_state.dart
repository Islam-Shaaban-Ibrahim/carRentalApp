import 'package:equatable/equatable.dart';
import 'package:qent/features/auth/domain/entities/user_entity.dart';

extension AuthStateX on AuthState {
  bool get isAuthStates =>
      this is AuthLoading || this is AuthSuccess || this is AuthError;

  bool get isSendVerifyCodeStates =>
      this is SendVerifyCodeLoading ||
      this is SendVerifyCodeSuccess ||
      this is SendVerifyCodeError;

  bool get isConfirmCodeStates =>
      this is ConfirmCodeLoading ||
      this is ConfirmCodeSuccess ||
      this is ConfirmCodeError;
}

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

final class SendVerifyCodeLoading extends AuthState {
  const SendVerifyCodeLoading();
}

final class SendVerifyCodeSuccess extends AuthState {
  final String verifyToken;
  const SendVerifyCodeSuccess(this.verifyToken);
  @override
  List<Object> get props => [verifyToken];
}

final class SendVerifyCodeError extends AuthState {
  final String message;
  const SendVerifyCodeError(this.message);
  @override
  List<Object> get props => [message];
}

final class ConfirmCodeLoading extends AuthState {
  const ConfirmCodeLoading();
}

final class ConfirmCodeSuccess extends AuthState {
  const ConfirmCodeSuccess();
}

final class ConfirmCodeError extends AuthState {
  final String message;
  const ConfirmCodeError(this.message);
  @override
  List<Object> get props => [message];
}
