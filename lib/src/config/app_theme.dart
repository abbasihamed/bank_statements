import 'package:flutter/material.dart';

class AppTheme {
  static const basicStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'yekan',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static ThemeData get appTheme {
    return ThemeData(
      textTheme: TextTheme(
        headline6: basicStyle.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        subtitle1:
            basicStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w600),
        subtitle2:
            basicStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w500),
        bodyText1: basicStyle,
        bodyText2: basicStyle.copyWith(
          fontSize: 16,
        ),
      ),
      backgroundColor: const Color(0xFF08111A),
      primaryColor: const Color(0xFFA34FE4),
      colorScheme: const ColorScheme.light(
        secondary: Color(0xFF303B46),
      ),
    );
  }
}
