import 'package:flutter/material.dart';

import 'injector.dart';
import 'src/config/app_routing.dart';
import 'src/config/app_theme.dart';
import 'src/core/app_keys.dart';

void main() {
  AppRoute.defineRoute();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مدیریت حساب بانکی',
      navigatorKey: navKey,
      theme: AppTheme.appTheme,
      onGenerateRoute: AppRoute.appRoute.generator,
      initialRoute: '/',
    );
  }
}
