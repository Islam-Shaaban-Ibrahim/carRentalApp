import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qent/generated/assets.dart';
import 'package:qent/generated/l10n.dart';

class LogoAndNameWidget extends StatelessWidget {
  const LogoAndNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.assetsIconsLogo, height: 38.h, width: 38.w),
        10.horizontalSpace,
        Text(
          S.current.appName,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
