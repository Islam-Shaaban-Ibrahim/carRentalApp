import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/resources/color_manager.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/core/shared/widgets/custom_button.dart';
import 'package:qent/generated/assets.dart';
import 'package:qent/generated/l10n.dart';

class LoginAndSignUpButtons extends StatelessWidget {
  const LoginAndSignUpButtons({super.key, this.isLogin = true});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          title: isLogin ? S.current.login : S.current.signUp,
          onPressed: () {},
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
        _bottomWidget(context, isLogin),
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

Widget _bottomWidget(BuildContext context, bool isLogin) {
  final style = Theme.of(context).textTheme;
  return InkWell(
    onTap: () {
      Navigator.pushReplacementNamed(
        context,
        isLogin ? AppRoutes.signUp : AppRoutes.login,
      );
    },
    child: RichText(
      text: TextSpan(
        text: isLogin
            ? S.current.doNotHaveAccount
            : S.current.alreadyHaveAccount,
        style: style.titleSmall!.copyWith(fontSize: 14.sp),
        children: [
          TextSpan(
            text: isLogin ? S.current.signUp : S.current.login,
            style: style.bodySmall!.copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    ),
  );
}
