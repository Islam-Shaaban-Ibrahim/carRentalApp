class APIConstants {
  static const String baseUrl = 'https://qent.azurewebsites.net/api';
  static const String getTokenEndPoint = '/auth/token/refresh/';
  static const String getAllCountriesEndPoint = '/public/countries';
  static const String getLocationsEndPoint = '/public/register_locations';
  static const String signUpEndPoint = '/auth/register/';
  static const String loginEndPoint = '/auth/login/';
  static String sendVerifyCodeEndPoint(bool isPhone) =>
      isPhone ? '/auth/phone/request_verify_code/' : '/auth/forgot_password/';
  static const String confirmPhoneCodeEndPoint =
      '/auth/phone/confirm_verify_code/';
}

class CacheConstants {
  static const String accessToken = 'ACCESS_TOKEN';
  static const String refreshToken = 'REFRESH_TOKEN';
  static const String user = 'USER';
  static const String onboarding = 'ONBOARDING';
}
