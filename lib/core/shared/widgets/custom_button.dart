import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/theme/color_manager.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final Color? titleColor;
  final Color? borderColor;
  final Icon? icon;

  final void Function() onPressed;
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = ColorManager.semiBlack,
    this.titleColor = ColorManager.white,
    this.icon,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
            side: BorderSide(color: borderColor ?? ColorManager.transparent),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon!.icon, color: Colors.black, size: 24),
              10.horizontalSpace,
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: titleColor,
                fontSize: icon != null ? 14.sp : 18.sp,
                fontWeight: icon != null ? FontWeight.w600 : FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
