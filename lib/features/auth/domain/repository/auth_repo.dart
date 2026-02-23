import 'package:qent/core/helpers/result.dart';
import 'package:qent/features/auth/data/models/sign_up_request_params.dart';
import 'package:qent/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Result<UserEntity>> login(String email, String password);
  Future<Result<UserEntity>> signUp(SignUpRequestParams params);
  Future<Result<String>> sendVerifyCode(String method, {required bool isPhone});
  Future<Result<void>> confirmPhoneCode(String token, String code);
}
