import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/presentation/widgets/custom_button.dart';
import 'package:qent/core/presentation/widgets/custom_rich_text.dart';
import 'package:qent/core/resources/color_manager.dart';
import 'package:qent/generated/l10n.dart';

class CustomVerificationCodeField extends StatefulWidget {
  final int length;

  final void Function(String code) onVerify;
  final void Function() onResend;
  final bool isLoading;
  final bool isDisabled;
  const CustomVerificationCodeField({
    super.key,
    this.length = 4,

    required this.onVerify,
    required this.onResend,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  State<CustomVerificationCodeField> createState() =>
      _CustomVerificationCodeFieldState();
}

class _CustomVerificationCodeFieldState
    extends State<CustomVerificationCodeField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(widget.length, (_) => TextEditingController());

    focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        focusNodes[index + 1].requestFocus();
      }
      setState(() {});
    }
  }

  void _onBackspace(int index) {
    if (index > 0 && controllers[index].text.isEmpty) {
      focusNodes[index - 1].requestFocus();
    }
    if (controllers[index].text.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium;
    final code = controllers.map((c) => c.text).join();
    return AbsorbPointer(
      absorbing: widget.isLoading,
      child: Column(
        children: [
          Row(
            spacing: 20.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              return SizedBox(
                width: 67.w,
                child: Focus(
                  onKeyEvent: (node, event) {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.backspace) {
                      _onBackspace(index);
                      controllers[index].clear();

                      return KeyEventResult.handled;
                    }
                    return KeyEventResult.ignored;
                  },
                  child: TextField(
                    enabled: !widget.isDisabled,
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,

                    cursorColor: ColorManager.primary,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: style!.copyWith(fontSize: 16.sp),
                    decoration: const InputDecoration(counterText: ''),
                    onChanged: (value) => _onChanged(value, index),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ),
              );
            }),
          ),
          40.verticalSpace,
          CustomButton(
            isLoading: widget.isLoading,
            title: S.current.verify,
            onPressed: code.length < widget.length
                ? null
                : () {
                    widget.onVerify(code);
                  },
          ),
          40.verticalSpace,
          CustomRichText(
            firstSpan: S.current.didNotReceiveOTP,
            secondSpan: S.current.resend,
            onTap: widget.onResend,
          ),
        ],
      ),
    );
  }
}
