import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/shared/widgets/custom_text_form_field.dart';
import 'package:qent/core/shared/widgets/logo_and_name_widget.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailOrPhoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LogoAndNameWidget(),
                    50.verticalSpace,
                    Text(
                      S.current.welcomeBack,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                    ),
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: S.current.password,
                      isPassword: true,
                    ),
                    30.verticalSpace,
                    RememberMeAndForgotPassword(
                      onForgotPassword: () {},
                      onRememberMeChanged: (value) {},
                    ),
                    30.verticalSpace,
                    const LoginAndSignUpButtons(),
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
