import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/models/country.dart';
import 'package:qent/core/shared/widgets/country_and_phone_text_field.dart';
import 'package:qent/core/shared/widgets/custom_text_form_field.dart';
import 'package:qent/core/shared/widgets/logo_and_name_widget.dart';
import 'package:qent/features/auth/presentation/widgets/login_and_sign_up_buttons.dart';
import 'package:qent/generated/l10n.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _countryController;
  final _formKey = GlobalKey<FormState>();
  Country? _country;
  bool isPhoneVerified = false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _countryController = TextEditingController();
    _country = countries.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _countryController.dispose();
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
                    Center(
                      child: Text(
                        S.current.signUp,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    30.verticalSpace,
                    CustomTextFormField(
                      controller: _nameController,
                      hintText: S.current.fullName,
                      heightAfterIt: 18.h,
                    ),
                    CustomTextFormField(
                      controller: _emailController,
                      hintText: S.current.emailAddress,
                      heightAfterIt: 18.h,
                    ),
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: S.current.password,
                      isPassword: true,
                      heightAfterIt: 18.h,
                    ),
                    CountryAndPhoneTextField(
                      controller: _countryController,
                      onSelectCountry: (country) => _country = country,
                      isPhoneVerified: isPhoneVerified,
                    ),
                    30.verticalSpace,
                    const LoginAndSignUpButtons(isLogin: false),
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
