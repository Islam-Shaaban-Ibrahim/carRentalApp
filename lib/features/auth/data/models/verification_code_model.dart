import 'package:qent/features/auth/domain/entities/verification_code_entity.dart';

class VerificationCodeModel {
  final String code;
  final String token;

  const VerificationCodeModel({required this.code, required this.token});

  factory VerificationCodeModel.fromJson(
    Map<String, dynamic> json, {
    required bool isPhone,
  }) {
    return VerificationCodeModel(
      code: json['code'],
      token: json[isPhone ? 'verify_token' : 'reset_token'],
    );
  }
}

extension FromModel on VerificationCodeModel {
  VerificationCodeEntity get fromModel =>
      VerificationCodeEntity(code: code, token: token);
}
