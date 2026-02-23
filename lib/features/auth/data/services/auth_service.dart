import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qent/core/constants.dart';
import 'package:qent/features/auth/data/models/sign_up_request_params.dart';

abstract class AuthService {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> signUp(SignUpRequestParams params);
  Future<String> sendVerifyCode(String method, {required bool isPhone});
  Future<Map<String, dynamic>> confirmPhoneCode(String token, String code);
}

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  final Dio _dio;

  AuthServiceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _dio.post(
      APIConstants.loginEndPoint,
      data: {'email': email, 'password': password},
    );
    return response.data;
  }

  @override
  Future<String> sendVerifyCode(String method, {required bool isPhone}) async {
    final response = await _dio.post(
      APIConstants.sendVerifyCodeEndPoint(isPhone),
      data: {isPhone ? 'phone' : 'email': method},
    );
    return response.data[isPhone ? 'verify_token' : 'reset_token'];
  }

  @override
  Future<Map<String, dynamic>> confirmPhoneCode(
    String token,
    String code,
  ) async {
    final result = await _dio.post(
      APIConstants.confirmPhoneCodeEndPoint,
      data: {'code': code, 'verify_token': token},
    );
    return result.data['user'];
  }

  @override
  Future<Map<String, dynamic>> signUp(SignUpRequestParams params) async {
    final response = await _dio.post(
      APIConstants.signUpEndPoint,
      data: params.toJson(),
    );
    return response.data;
  }
}
