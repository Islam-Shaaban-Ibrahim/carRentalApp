import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/helpers/app_banner.dart';
import 'package:qent/core/helpers/validator.dart';
import 'package:qent/core/presentation/widgets/app_scaffold.dart';
import 'package:qent/core/presentation/widgets/custom_text_form_field.dart';
import 'package:qent/core/presentation/widgets/logo_and_name_widget.dart';
import 'package:qent/features/auth/auth_helpers.dart';
import 'package:qent/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:qent/features/auth/presentation/cubit/auth_state.dart';
import 'package:qent/features/auth/presentation/widgets/login_and_sign_up_buttons.dart';
import 'package:qent/features/auth/presentation/widgets/remember_me_and_forgot_password.dart';
import 'package:qent/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailOrPhoneController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    _emailOrPhoneController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthCubit>().state is AuthLoading;
    return AppScaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) => current.isAuthStates,
        listener: (_, state) {
          if (state is AuthError) {
            showAppBanner(state.message, isError: true);
          }
          if (state is AuthSuccess) {
            handleSuccessNavigation(context, state.user);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: AbsorbPointer(
                  absorbing: isLoading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LogoAndNameWidget(),
                      50.verticalSpace,
                      Text(
                        S.current.welcomeBack,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.4.h,
                            ),
                      ),
                      40.verticalSpace,
                      CustomTextFormField(
                        controller: _emailOrPhoneController,
                        hintText: S.current.emailOrPhone,
                        heightAfterIt: 18.h,
                        validate: Validator.isValidEmail,
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: S.current.password,
                        isPassword: true,
                        validate: Validator.isValidPassword,
                      ),
                      30.verticalSpace,
                      RememberMeAndForgotPassword(
                        onForgotPassword: () {},
                        onRememberMeChanged: (value) {},
                      ),
                      30.verticalSpace,
                      LoginAndSignUpButtons(
                        isLoading: isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                              email: _emailOrPhoneController.text,
                              password: _passwordController.text,
                            );
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
      ),
    );
  }
}
