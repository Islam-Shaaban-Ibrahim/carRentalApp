import 'dart:async';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:qent/core/helpers/helper_methods.dart';

abstract class InternetConnectionService {
  Future<bool> checkInternetConnection();
}

@LazySingleton(as: InternetConnectionService)
class InternetConnectionServiceImpl extends InternetConnectionService {
  static final HttpClient _client = HttpClient();

  @override
  Future<bool> checkInternetConnection() async {
    const timeout = Duration(seconds: 3);

    final urls = [
      'https://www.gstatic.com/generate_204',
      'https://www.google.com/generate_204',
      'https://clients3.google.com/generate_204',
    ];

    for (final url in urls) {
      try {
        final request = await _client.getUrl(Uri.parse(url)).timeout(timeout);

        final response = await request.close().timeout(timeout);
        await response.drain();

        debugLog(
          message: 'URL: $url | Status: ${response.statusCode}',
          name: 'checkInternetConnection',
        );

        if (response.statusCode == 204) {
          return true;
        }
      } catch (e) {
        debugLog(
          message: 'URL: $url | Error: $e',
          name: 'checkInternetConnection',
        );
        continue;
      }
    }

    return false;
  }
}
