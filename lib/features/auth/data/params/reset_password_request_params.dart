class ResetPasswordRequestParams {
  final String resetToken;
  final String code;
  final String password;
  final String confirmPassword;

  ResetPasswordRequestParams({
    required this.resetToken,
    required this.code,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'reset_token': resetToken,
      'code': code,
      'password': password,
      'confirm_password': confirmPassword,
    };
  }
}
