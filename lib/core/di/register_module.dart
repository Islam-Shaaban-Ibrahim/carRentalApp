import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:qent/core/constants.dart';
import 'package:qent/core/di/service_locator.dart';
import 'package:qent/core/helpers/app_banner.dart';
import 'package:qent/core/helpers/helper_methods.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/core/services/cache_service.dart';
import 'package:qent/core/services/internet_connection_service.dart';
import 'package:qent/generated/l10n.dart';
import 'package:qent/main.dart';

Completer<String?>?
_refreshCompleter; //we use this to prevent multiple refreshes
// and race condition

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: APIConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.addAll([
      if (kDebugMode)
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (object) => debugLog(message: object.toString(), name: ''),
        ),

      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final internetConnection =
              serviceLocator<InternetConnectionService>();
          if (!await internetConnection.checkInternetConnection()) {
            return handler.reject(
              DioException(
                requestOptions: options,
                message: S.current.noInternetConnection,
              ),
            );
          } else {
            final secureStorage = serviceLocator<SecureStorage>();
            final token = await secureStorage.get(CacheConstants.accessToken);
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          }
        },
        onError: (error, handler) async {
          if (error.response != null &&
              error.response!.statusCode == 401 &&
              error.requestOptions.path != APIConstants.getTokenEndPoint) {
            // If a refresh is already running, wait for it
            if (_refreshCompleter != null) {
              await _refreshCompleter!.future;
            } else {
              _refreshCompleter = Completer();
              try {
                final newToken = await _refreshAndGetNewToken(
                  error.requestOptions,
                );

                debugLog(
                  message: 'New access token: $newToken',
                  name: '_refreshAndGetNewToken',
                );

                if (newToken != null) {
                  _refreshCompleter!.complete(newToken);

                  // Retry the original request after refresh
                  final requestOptions = error.requestOptions;

                  requestOptions.headers['Authorization'] = 'Bearer $newToken';

                  final response = await dio.fetch(requestOptions);
                  return handler.resolve(response);
                }
              } catch (e) {
                if (e is DioException &&
                    e.message == S.current.noInternetConnection) {
                  return handler.reject(e);
                }
                return _logoutUser(); // log out
              } finally {
                if (_refreshCompleter?.isCompleted == false) {
                  _refreshCompleter!.complete(null);
                }
                _refreshCompleter = null;
              }
            }
          }

          return handler.next(error);
        },
      ),
    ]);
    return dio;
  }
}

Future<String?> _refreshAndGetNewToken(RequestOptions requestOptions) async {
  final secureStorage = serviceLocator<SecureStorage>();
  final internet = serviceLocator<InternetConnectionService>();

  final refreshToken = await secureStorage.get(CacheConstants.refreshToken);
  final accessToken = await secureStorage.get(CacheConstants.accessToken);

  if (await internet.checkInternetConnection() == false) {
    throw DioException(
      requestOptions: requestOptions,
      message: S.current.noInternetConnection,
    );
  }

  final response = await Dio(
    BaseOptions(
      baseUrl: APIConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {'Authorization': 'Bearer $accessToken'},
    ),
  ).post(APIConstants.getTokenEndPoint, data: {'refresh': refreshToken});

  final newAccessToken = response.data['access'];
  final newRefresh = response.data['refresh'];
  if (newAccessToken != null && newRefresh != null) {
    await secureStorage.save(CacheConstants.accessToken, newAccessToken);
    await secureStorage.save(CacheConstants.refreshToken, newRefresh);
  }
  return newAccessToken as String?;
}

void _logoutUser() {
  final secureStorage = serviceLocator<SecureStorage>();
  secureStorage.deleteAll();
  final context = navigatorKey.currentContext!;

  if (context.mounted) {
    showAppBanner(S.current.sessionExpired);
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }
}
