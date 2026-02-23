import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:qent/core/constants.dart';
import 'package:qent/core/di/service_locator.dart';
import 'package:qent/core/helpers/helper_methods.dart';
import 'package:qent/core/helpers/result.dart';
import 'package:qent/core/services/cache_service.dart';
import 'package:qent/features/auth/data/models/sign_up_request_params.dart';
import 'package:qent/features/auth/data/models/user_model.dart';
import 'package:qent/features/auth/data/services/auth_service.dart';
import 'package:qent/features/auth/domain/entities/user_entity.dart';
import 'package:qent/features/auth/domain/repository/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthService _authService;
  AuthRepoImpl(this._authService);
  @override
  Future<Result<UserEntity>> login(String email, String password) async {
    try {
      final json = await _authService.login(email, password);
      await _saveTokensAndUser(json);
      return Result.success(UserModel.fromJson(json['user']).fromModel);
    } catch (e) {
      return Result.error(getErrorMessage(e));
    }
  }

  @override
  Future<Result<String>> sendVerifyCode(
    String method, {
    required bool isPhone,
  }) async {
    try {
      return Result.success(
        await _authService.sendVerifyCode(method, isPhone: isPhone),
      );
    } catch (e) {
      return Result.error(getErrorMessage(e));
    }
  }

  @override
  Future<Result<void>> confirmPhoneCode(String token, String code) async {
    try {
      final user = await _authService.confirmPhoneCode(token, code);
      await _saveUser(user);
      return const Result.success(null);
    } catch (e) {
      return Result.error(getErrorMessage(e));
    }
  }

  @override
  Future<Result<UserEntity>> signUp(SignUpRequestParams params) async {
    try {
      final json = await _authService.signUp(params);
      await _saveTokensAndUser(json);
      return Result.success(UserModel.fromJson(json['user']).fromModel);
    } catch (e) {
      return Result.error(getErrorMessage(e));
    }
  }
}

Future<void> _saveTokensAndUser(Map<String, dynamic>? json) async {
  final secureStorage = serviceLocator<SecureStorage>();
  if (json != null) {
    final access = json['tokens']?['access'];
    final refresh = json['tokens']?['refresh'];
    final user = json['user'];
    if (access != null && refresh != null && user != null) {
      await secureStorage.save(CacheConstants.accessToken, access);
      await secureStorage.save(CacheConstants.refreshToken, refresh);
      await _saveUser(user);
    }
  }
}

Future<void> _saveUser(Map<String, dynamic>? json) async {
  final secureStorage = serviceLocator<SecureStorage>();
  if (json != null) {
    await secureStorage.save(CacheConstants.user, jsonEncode(json));
  }
}
