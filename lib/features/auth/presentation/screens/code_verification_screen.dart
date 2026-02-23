import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/helpers/app_banner.dart';
import 'package:qent/core/presentation/widgets/app_scaffold.dart';
import 'package:qent/core/presentation/widgets/custom_verification_code_field.dart';
import 'package:qent/core/presentation/widgets/loading_widget.dart';
import 'package:qent/core/presentation/widgets/logo_and_name_widget.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:qent/features/auth/presentation/cubit/auth_state.dart';
import 'package:qent/generated/l10n.dart';

class CodeVerificationScreen extends StatefulWidget {
  const CodeVerificationScreen({
    super.key,
    required this.verifiedMethod,
    required this.isPhone,
  });
  final String verifiedMethod;
  final bool isPhone;

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  String token = '';
  @override
  void initState() {
    super.initState();
    _sendCode();
  }

  void _sendCode() {
    context.read<AuthCubit>().sendVerifyCode(
      widget.verifiedMethod,
      isPhone: widget.isPhone,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return AppScaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            current.isSendVerifyCodeStates || current.isConfirmCodeStates,
        listenWhen: (previous, current) =>
            current.isSendVerifyCodeStates || current.isConfirmCodeStates,
        listener: (context, state) {
          if (state is SendVerifyCodeError) {
            showAppBanner( state.message, isError: true);
          } else if (state is ConfirmCodeError) {
            showAppBanner( state.message, isError: true);
          } else if (state is SendVerifyCodeSuccess) {
            token = state.verifyToken;
            showAppBanner( S.current.codeSentSuccessfully);
          } else if (state is ConfirmCodeSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              widget.isPhone ? AppRoutes.home : AppRoutes.resetPassword,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is SendVerifyCodeLoading,
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LogoAndNameWidget(),
                      45.verticalSpace,
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              S.current.enterVerificationCode,
                              style: style.titleMedium!.copyWith(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            10.verticalSpace,
                            Text(
                              S.current.weHaveSentACodeTo(
                                widget.verifiedMethod,
                              ),
                              style: style.titleSmall!.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            20.verticalSpace,
                            CustomVerificationCodeField(
                              isLoading: state is ConfirmCodeLoading,
                              isDisabled: token.isEmpty,
                              onResend: () {
                                token = '';
                                _sendCode();
                              },
                              onVerify: (code) {
                                context.read<AuthCubit>().confirmPhoneCode(
                                  token,
                                  code,
                                );
                              },
                            ),
                            40.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state is SendVerifyCodeLoading) const LoadingWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
