import 'package:bank_statements/injector.dart';
import 'package:flutter/material.dart';

import 'src/config/app_routing.dart';
import 'src/config/app_theme.dart';

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
      theme: AppTheme.appTheme,
      onGenerateRoute: AppRoute.appRoute.generator,
      initialRoute: '/',
    );
  }
}
