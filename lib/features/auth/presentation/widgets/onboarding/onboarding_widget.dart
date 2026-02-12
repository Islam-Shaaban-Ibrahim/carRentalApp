import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/constants/assets.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          path,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          top: 20.h,
          left: 24.w,
          child: Image.asset(Assets.assetsImagesAppLogo),
        ),
      ],
    );
  }
}
