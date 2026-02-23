import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/constants.dart';
import 'package:qent/core/di/service_locator.dart';
import 'package:qent/core/presentation/widgets/app_scaffold.dart';
import 'package:qent/core/presentation/widgets/custom_button.dart';
import 'package:qent/core/presentation/widgets/custom_page_indicator.dart';
import 'package:qent/core/presentation/widgets/onboarding_widget.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/core/services/cache_service.dart';
import 'package:qent/generated/assets.dart';
import 'package:qent/generated/l10n.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late final PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(
      const AssetImage(Assets.assetsImagesOnboardingSecond),
      context,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: true,
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              OnboardingWidget(
                path: Assets.assetsImagesOnboardingFirst,
                text: S.current.welcomeToQent,
              ),
              OnboardingWidget(
                path: Assets.assetsImagesOnboardingSecond,
                text: S.current.letsStartANewExperience,
                bottomText: S.current.discoverYourNextAdventure,
              ),
            ],
          ),
          Positioned(
            bottom: 50.h,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  spacing: 40.h,
                  children: [
                    CustomPageIndicator(currentIndex: currentIndex, count: 2),

                    CustomButton(
                      title: currentIndex == 0
                          ? S.current.next
                          : S.current.getStarted,
                      onPressed: () {
                        if (currentIndex == 0) {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login,
                          );
                          serviceLocator<SecureStorage>().save(
                            CacheConstants.onboarding,
                            'true',
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
