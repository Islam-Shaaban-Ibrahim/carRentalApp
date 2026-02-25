import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/helpers/app_banner.dart';
import 'package:qent/core/helpers/validator.dart';
import 'package:qent/core/presentation/widgets/app_scaffold.dart';
import 'package:qent/core/presentation/widgets/custom_button.dart';
import 'package:qent/core/presentation/widgets/custom_text_form_field.dart';
import 'package:qent/core/presentation/widgets/logo_and_name_widget.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/features/auth/data/params/reset_password_request_params.dart';
import 'package:qent/features/auth/domain/entities/verification_code_entity.dart';
import 'package:qent/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:qent/features/auth/presentation/cubit/auth_state.dart';
import 'package:qent/generated/l10n.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final GlobalKey<FormState> _formKey;
  VerificationCodeEntity? verificationCode;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthCubit>().state is ResetPasswordLoading;
    final style = Theme.of(context).textTheme;
    return AppScaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) => current.isResetPasswordStates,
        listener: (_, state) {
          if (state is ResetPasswordError) {
            showAppBanner(state.message, isError: true);
          }
          if (state is ResetPasswordSuccess) {
            showAppBanner(S.current.passwordResetSuccessfully);
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: AbsorbPointer(
                absorbing: isLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LogoAndNameWidget(),
                    50.verticalSpace,
                    Center(
                      child: Column(
                        children: [
                          Text(
                            S.current.resetYourPassword,
                            style: style.titleMedium!.copyWith(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.4.h,
                            ),
                          ),
                          10.verticalSpace,
                          Text(
                            S
                                .current
                                .enterTheEmailAddressAssociatedWithYourAccount,
                            textAlign: TextAlign.center,
                            style: style.titleSmall!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    40.verticalSpace,
                    CustomTextFormField(
                      enabled: verificationCode == null,
                      controller: _emailController,
                      hintText: S.current.emailAddress,
                      heightAfterIt: 18.h,
                      validate: Validator.isValidEmail,
                    ),
                    if (verificationCode != null) ...[
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: S.current.password,
                        isPassword: true,
                        heightAfterIt: 18.h,
                        validate: Validator.isValidPassword,
                      ),
                      CustomTextFormField(
                        controller: _confirmPasswordController,
                        hintText: S.current.confirmPassword,
                        isPassword: true,
                        validate: (value) => Validator.confirmPassword(
                          value,
                          _passwordController.text,
                        ),
                      ),
                    ],
                    40.verticalSpace,

                    CustomButton(
                      title: verificationCode == null
                          ? S.current.continuee
                          : S.current.reset,
                      isLoading: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (verificationCode == null) {
                            Navigator.of(context)
                                .pushNamed(
                                  AppRoutes.codeVerification,
                                  arguments: {
                                    'method': _emailController.text.trim(),
                                    'isPhone': false,
                                  },
                                )
                                .then(
                                  (value) => {
                                    if (value != null &&
                                        value is VerificationCodeEntity)
                                      {
                                        setState(() {
                                          verificationCode = value;
                                        }),
                                      },
                                  },
                                );
                          } else {
                            context.read<AuthCubit>().resetPassword(
                              ResetPasswordRequestParams(
                                code: verificationCode!.code,
                                resetToken: verificationCode!.token,
                                password: _passwordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
