import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qent/core/resources/color_manager.dart';
import 'package:qent/generated/assets.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final double heightAfterIt;
  final bool readOnly;
  final String? hintText;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? errorText;
  final TextDirection? textDirection;
  final Widget? prefix;
  final Widget? textFormFieldIcon;
  final String? initialValue;
  final TextInputType? keyboardType;
  final dynamic Function(String)? onSubmit;
  final dynamic Function(String)? onChange;
  final dynamic Function()? onTap;
  final String? Function(String?)? validate;
  final bool isPassword;
  final bool? enabled;
  final String? suffixIcon;
  final dynamic Function()? suffixPressed;
  final BoxConstraints? constraints;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextAlign? textAlign;
  final int? maxLines;
  final String? counterText;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  const CustomTextFormField({
    this.controller,
    this.validate,
    super.key,
    this.title,
    this.counterText,
    this.maxLength,
    this.heightAfterIt = 0,

    this.focusNode,
    this.textDirection,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.errorText,
    this.keyboardType = TextInputType.text,

    this.textFormFieldIcon,
    this.autofocus = false,
    this.readOnly = false,
    this.prefix,
    this.contextMenuBuilder,
    this.initialValue,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.enabled,
    this.suffixIcon,
    this.suffixPressed,
    this.constraints,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.hintText,
    this.isPassword = false,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final fontSize = 16.sp;
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment!,
      children: [
        if (widget.title != null) Text(widget.title!, style: style.titleMedium),
        if (widget.title != null) SizedBox(height: 10.h),
        TextFormField(
          cursorColor: ColorManager.primary,
          readOnly: widget.readOnly,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: isObscure,
          textDirection: widget.textDirection,
          textAlign: widget.textAlign!,
          onFieldSubmitted: widget.onSubmit,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          onChanged: widget.onChange,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          contextMenuBuilder: widget.contextMenuBuilder,
          maxLines: widget.maxLines,
          validator: widget.validate,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          textCapitalization: widget.textCapitalization,
          textAlignVertical: TextAlignVertical.center,
          style: style.bodySmall!.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
          initialValue: widget.initialValue,
          decoration: InputDecoration(
            icon: widget.textFormFieldIcon,
            errorText: widget.errorText,
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
            ),
            constraints: widget.constraints,
            counterText: widget.counterText,
            hintStyle: style.titleSmall!.copyWith(fontSize: fontSize),
            errorStyle: style.bodyLarge!.copyWith(fontSize: fontSize),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffixIcon == null && !widget.isPassword
                ? null
                : GestureDetector(
                    onTap: widget.isPassword
                        ? () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          }
                        : widget.suffixPressed,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 20.h,
                        maxWidth: 20.w,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(13.w),
                        child: SvgPicture.asset(
                          widget.isPassword
                              ? isObscure
                                    ? Assets.assetsIconsEyeOff
                                    : Assets.assetsIconsEyeOn
                              : widget.suffixIcon!,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        SizedBox(height: widget.heightAfterIt),
      ],
    );
  }
}
