import 'package:com_nico_develop_podcasting/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomThemeData {
  static final ThemeData defaultTheme = _buildCustomThemeData();

  static ThemeData _buildCustomThemeData() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      scaffoldBackgroundColor: kDefaultBackgroundColor,
      textTheme: TextTheme(
        titleLarge: const TextStyle(
          fontSize: kDefaultFontSize * 1.1,
          color: kDefaultTextTitleColor,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: kDefaultFontSize,
          height: 1.4,
          letterSpacing: .5,
          color: Colors.grey.withOpacity(.8),
          fontWeight: FontWeight.w500,
        ),
        titleSmall: const TextStyle(
          fontSize: kDefaultFontSize * 1,
          color: kDefaultTextTitleColor,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: const TextStyle(
          fontSize: kDefaultFontSize * .95,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
