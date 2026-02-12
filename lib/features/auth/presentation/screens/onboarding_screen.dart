import 'package:flutter/material.dart';
import 'package:qent/constants/assets.dart';
import 'package:qent/core/color_manager.dart';

import 'package:qent/features/auth/presentation/widgets/onboarding/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorManager.whiteColor,
      extendBody: true,
      body: SafeArea(
        child: PageView(
          children: const [
            OnboardingWidget(path: Assets.assetsImagesOnboardingFirst),
            OnboardingWidget(path: Assets.assetsImagesOnboardingSecond),
          ],
        ),
      ),
    );
  }
}
