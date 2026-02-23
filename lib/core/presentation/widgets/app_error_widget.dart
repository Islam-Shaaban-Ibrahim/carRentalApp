import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/resources/color_manager.dart';

import '../../../generated/l10n.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.message, this.onRefresh});
  final String message;
  final VoidCallback? onRefresh;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: textTheme.bodyLarge!.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRefresh != null) ...[
            10.verticalSpace,
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: ColorManager.lightGrey,
              ),
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh, color: ColorManager.primary),
              label: Text(
                S.current.tryAgain,
                style: textTheme.titleSmall!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
