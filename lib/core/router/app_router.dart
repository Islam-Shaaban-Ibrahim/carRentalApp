import 'package:flutter/material.dart';
import 'package:qent/features/auth/presentation/screens/login_screen.dart';
import 'package:qent/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:qent/features/auth/presentation/screens/sign_up_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const Placeholder());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No Page Found'))),
        );
    }
  }
}

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/sign_up';
  static const String verifyPhone = '/verify_phone';
  static const String verifyEmail = '/verify_email';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
}
