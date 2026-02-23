import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qent/core/constants.dart';
import 'package:qent/core/di/service_locator.dart';
import 'package:qent/core/presentation/widgets/app_scaffold.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/core/services/cache_service.dart';
import 'package:qent/features/auth/data/models/user_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    handleNavigation();
  }

  Future<void> handleNavigation() async {
    final storage = serviceLocator<SecureStorage>();
    final token = await storage.get(CacheConstants.accessToken);
    final showOnboarding = await storage.get(CacheConstants.onboarding);

    if (mounted && showOnboarding == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.onboarding,
        (route) => false,
      );
      return;
    }

    if (token == null && mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    } else {
      final json = await storage.get(CacheConstants.user);
      if (json != null && mounted) {
        final user = UserModel.fromJson(jsonDecode(json)).fromModel;
        if (user.phoneIsVerified) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        } else {
          Navigator.of(context)
            ..pushReplacementNamed(AppRoutes.login)
            ..pushNamed(
              AppRoutes.codeVerification,

              arguments: {'method': user.phone, 'isPhone': true},
            );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 25),
        ),
      ),
    );
  }
}
