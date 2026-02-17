import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/resources/color_manager.dart';
import 'package:qent/generated/l10n.dart';

class RememberMeAndForgotPassword extends StatefulWidget {
  final ValueChanged<bool?> onRememberMeChanged;
  final void Function()? onForgotPassword;

  const RememberMeAndForgotPassword({
    super.key,

    required this.onRememberMeChanged,
    this.onForgotPassword,
  });

  @override
  State<RememberMeAndForgotPassword> createState() =>
      _RememberMeAndForgotPasswordState();
}

class _RememberMeAndForgotPasswordState
    extends State<RememberMeAndForgotPassword> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Row(
      children: [
        SizedBox(
          height: 20.w,
          width: 20.w,
          child: Checkbox(
            value: value,
            onChanged: (value) {
              setState(() => this.value = value ?? false);
              widget.onRememberMeChanged(value);
            },
            activeColor: ColorManager.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        10.horizontalSpace,
        GestureDetector(
          onTap: () => widget.onRememberMeChanged(!value),
          child: Text(
            S.current.rememberMe,
            style: style.titleSmall!.copyWith(fontSize: 14.sp),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: widget.onForgotPassword,
          child: Text(
            S.current.forgotPassword,
            style: style.bodySmall!.copyWith(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
