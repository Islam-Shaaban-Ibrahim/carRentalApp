import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/domain/entities/country_entity.dart';
import 'package:qent/core/domain/entities/location_entity.dart';
import 'package:qent/core/helpers/app_banner.dart';
import 'package:qent/core/helpers/validator.dart';
import 'package:qent/core/presentation/widgets/app_scaffold.dart';
import 'package:qent/core/presentation/widgets/country_and_phone_text_field.dart';
import 'package:qent/core/presentation/widgets/custom_text_form_field.dart';
import 'package:qent/core/presentation/widgets/logo_and_name_widget.dart';
import 'package:qent/core/presentation/widgets/select_location_dialog.dart';
import 'package:qent/features/auth/auth_helpers.dart';
import 'package:qent/features/auth/data/models/sign_up_request_params.dart';
import 'package:qent/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:qent/features/auth/presentation/cubit/auth_state.dart';
import 'package:qent/features/auth/presentation/widgets/available_to_create_car.dart';
import 'package:qent/features/auth/presentation/widgets/login_and_sign_up_buttons.dart';
import 'package:qent/generated/assets.dart';
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
  late final TextEditingController _locationController;
  late final TextEditingController _nIDController;
  late final TextEditingController _dobController;
  late final GlobalKey<FormState> _formKey;
  CountryEntity? _country;
  LocationEntity? _location;
  bool availableToCreateCar = false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _countryController = TextEditingController();
    _locationController = TextEditingController();
    _nIDController = TextEditingController();
    _dobController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _countryController.dispose();
    _locationController.dispose();
    _nIDController.dispose();
    _dobController.dispose();
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
            showAppBanner( state.message, isError: true);
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
                        validate: Validator.isValidName,
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: S.current.emailAddress,
                        heightAfterIt: 18.h,
                        validate: Validator.isValidEmail,
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: S.current.password,
                        isPassword: true,
                        heightAfterIt: 18.h,
                        validate: Validator.isValidPassword,
                      ),
                      CountryAndPhoneTextField(
                        controller: _countryController,
                        onSelectCountry: (country) => _country = country,

                        validate: (value) {
                          if (_country == null) {
                            return S.current.selectCountry;
                          }
                          return Validator.isValidPhoneNumber(value);
                        },
                      ),
                      8.verticalSpace,
                      GestureDetector(
                        onTap: () async {
                          final location = await showLocationDialog(context);
                          if (location != null) {
                            setState(() {
                              _locationController.text = location.name;
                              _location = location;
                            });
                          }
                        },
                        child: CustomTextFormField(
                          controller: _locationController,
                          hintText: S.current.selectLocation,
                          enabled: false,
                          suffixIcon: Assets.assetsIconsDropDown,
                          prefix: const Icon(Icons.location_on),
                          validate: Validator.isValidField,
                        ),
                      ),
                      30.verticalSpace,
                      AvailableToCreateCar(
                        nIDController: _nIDController,
                        dobController: _dobController,
                        onChanged: (value) {
                          setState(() {
                            availableToCreateCar = value;
                          });
                        },
                      ),
                      30.verticalSpace,
                      LoginAndSignUpButtons(
                        isLoading: isLoading,
                        isLogin: false,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signUp(
                              SignUpRequestParams(
                                fullName: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                countryId: _country!.id,
                                phone: _countryController.text,
                                locationId: _location!.id,
                                availableToCreateCar: availableToCreateCar,
                                nationalId: _nIDController.text,
                                dateOfBirth: _dobController.text,
                              ),
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
