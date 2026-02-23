import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/presentation/widgets/custom_button.dart';
import 'package:qent/core/presentation/widgets/custom_rich_text.dart';
import 'package:qent/core/resources/color_manager.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/generated/assets.dart';
import 'package:qent/generated/l10n.dart';

class LoginAndSignUpButtons extends StatelessWidget {
  const LoginAndSignUpButtons({
    super.key,
    this.isLogin = true,
    this.onPressed,
    this.isLoading = false,
  });
  final bool isLogin;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          isLoading: isLoading,
          title: isLogin ? S.current.login : S.current.signUp,
          onPressed: onPressed,
        ),
        18.verticalSpace,
        CustomButton(
          title: isLogin ? S.current.signUp : S.current.login,
          borderColor: ColorManager.primary,
          backgroundColor: ColorManager.secondary,
          titleColor: ColorManager.black,
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              isLogin ? AppRoutes.signUp : AppRoutes.login,
            );
          },
        ),
        28.verticalSpace,
        _orWidget(context),
        28.verticalSpace,
        CustomButton(
          iconPath: Assets.assetsIconsApple,
          title: S.current.apple,
          backgroundColor: ColorManager.secondary,
          titleColor: ColorManager.black,
          onPressed: () {},
        ),
        18.verticalSpace,
        CustomButton(
          iconPath: Assets.assetsIconsGoogle,
          title: S.current.google,
          backgroundColor: ColorManager.secondary,
          titleColor: ColorManager.black,
          onPressed: () {},
        ),
        45.verticalSpace,
        CustomRichText(
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              isLogin ? AppRoutes.signUp : AppRoutes.login,
            );
          },
          firstSpan: isLogin
              ? S.current.doNotHaveAccount
              : S.current.alreadyHaveAccount,
          secondSpan: isLogin ? S.current.signUp : S.current.login,
        ),
      ],
    );
  }

  Widget _orWidget(BuildContext context) => Row(
    children: [
      Expanded(
        child: Container(height: 1.h, color: ColorManager.lightGrey),
      ),
      20.horizontalSpace,
      Text(S.current.or, style: Theme.of(context).textTheme.titleSmall),
      20.horizontalSpace,
      Expanded(
        child: Container(height: 1.h, color: ColorManager.lightGrey),
      ),
    ],
  );
}
