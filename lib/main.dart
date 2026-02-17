import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/resources/app_theme.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:qent/generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<OverlayState> globalOverlayKey = GlobalKey<OverlayState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          builder: (context, child) => Overlay(
            key: globalOverlayKey,
            initialEntries: [OverlayEntry(builder: (context) => child!)],
          ),

          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          theme: AppTheme.mainTheme,
          initialRoute: AppRoutes.login,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen();
  }
}
