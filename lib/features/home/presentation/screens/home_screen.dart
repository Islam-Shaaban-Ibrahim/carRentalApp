import 'package:flutter/material.dart';
import 'package:qent/core/presentation/widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('Home Screen')));
  }
}
