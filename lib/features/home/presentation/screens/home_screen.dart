import 'package:flutter/material.dart';
import 'package:qent/core/di/service_locator.dart';
import 'package:qent/core/presentation/widgets/app_scaffold.dart';
import 'package:qent/core/services/cache_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('Home Screen')));
  }
}
