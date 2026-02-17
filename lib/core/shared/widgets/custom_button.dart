import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qent/core/resources/color_manager.dart';
import 'package:qent/core/shared/widgets/loading_widget.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final Color? titleColor;
  final Color? borderColor;
  final String? iconPath;
  final bool isLoading;

  final void Function() onPressed;
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = ColorManager.semiBlack,
    this.titleColor = ColorManager.white,
    this.iconPath,
    this.borderColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: iconPath != null ? 50.h : 62.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
            side: BorderSide(color: borderColor ?? ColorManager.transparent),
          ),
        ),
        child: isLoading
            ? const LoadingWidget()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconPath != null) ...[
                    SvgPicture.asset(iconPath!, height: 20.h, width: 20.w),
                    10.horizontalSpace,
                  ],
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: titleColor,
                      fontSize: iconPath != null ? 14.sp : 18.sp,
                      fontWeight: iconPath != null
                          ? FontWeight.w600
                          : FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
