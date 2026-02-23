import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qent/generated/l10n.dart';

void debugLog({required String message, required String name}) {
  if (kDebugMode) {
    log(message, name: name);
  }
}

String getFlagEmoji(String countryAbbreviation) {
  return countryAbbreviation.toUpperCase().replaceAllMapped(
    RegExp(r'[A-Z]'),
    (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
  );
}

String? _getErrorMessageFromResponse(dynamic json) {
  if (json != null && json is Map<String, dynamic>) {
    final message = json['errors']?['message'];
    if (message != null && message is String) {
      return message;
    } else if (message != null && message is List<dynamic>) {
      return message.first;
    }
  }
  return null;
}

String getErrorMessage(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response);
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.unknown:
        return error.message == S.current.noInternetConnection
            ? S.current.noInternetConnection
            : 'Unknown error occurred';
      default:
        return 'Unexpected error occurred';
    }
  }
  return error.toString();
}

String _handleStatusCode(Response<dynamic>? response) {
  final errorMessage = _getErrorMessageFromResponse(response?.data);

  if (errorMessage != null) {
    return errorMessage;
  }

  switch (response?.statusCode) {
    case 400:
      return 'Bad request';
    case 401:
      return 'Unauthorized';
    case 403:
      return 'Forbidden';
    case 404:
      return 'Not found';
    case 500:
      return 'Server error';
    default:
      return 'Something went wrong';
  }
}
