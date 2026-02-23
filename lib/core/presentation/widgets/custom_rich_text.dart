import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.firstSpan,
    required this.secondSpan,
    this.onTap,
  });
  final String firstSpan;
  final String secondSpan;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: firstSpan,
          style: style.titleSmall!.copyWith(fontSize: 14.sp),
          children: [
            TextSpan(
              text: secondSpan,
              style: style.bodySmall!.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
