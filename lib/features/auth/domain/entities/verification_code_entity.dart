import 'package:equatable/equatable.dart';

class VerificationCodeEntity extends Equatable {
  final String code;
  final String token;

  const VerificationCodeEntity({required this.code, required this.token});

  @override
  List<Object?> get props => [code, token];
}
