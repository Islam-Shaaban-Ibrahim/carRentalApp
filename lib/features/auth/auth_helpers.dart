import 'package:flutter/material.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/features/auth/domain/entities/user_entity.dart';

void handleSuccessNavigation(BuildContext context, UserEntity user) {
  if (!user.phoneIsVerified) {
    Navigator.of(context).pushNamed(
      AppRoutes.codeVerification,
      arguments: {'method': user.phone, 'isPhone': true},
    );
  } else {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }
}
