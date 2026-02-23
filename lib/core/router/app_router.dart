import 'package:flutter/material.dart';
import 'package:qent/core/presentation/screens/splash_screen.dart';
import 'package:qent/features/auth/presentation/screens/code_verification_screen.dart';
import 'package:qent/features/auth/presentation/screens/login_screen.dart';
import 'package:qent/core/presentation/screens/onboarding_screen.dart';
import 'package:qent/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:qent/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.codeVerification:
        return MaterialPageRoute(
          builder: (_) {
            final args = settings.arguments as Map<String, dynamic>;
            return CodeVerificationScreen(
              verifiedMethod: args['method'],
              isPhone: args['isPhone'],
            );
          },
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No Page Found'))),
        );
    }
  }
}

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/sign_up';
  static const String codeVerification = '/code_verification';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
}
