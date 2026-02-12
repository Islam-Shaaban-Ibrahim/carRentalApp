import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/generated/assets.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.path,
    required this.text,
    this.bottomText,
  });
  final String path;
  final String text;
  final String? bottomText;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleLarge;
    return Stack(
      children: [
        Image.asset(
          path,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 20.h,
            horizontal: 24.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(Assets.assetsImagesAppLogo),
              50.verticalSpace,
              Text(text, style: style!.copyWith(fontSize: 45.sp)),
              if (bottomText != null) ...[
                const Spacer(flex: 2),
                Text(
                  bottomText!,
                  style: style.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
