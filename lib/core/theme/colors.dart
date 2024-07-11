import 'package:flutter/material.dart';

class AppColor {
  static final AppColor _singleton = AppColor._internal();

  factory AppColor() {
    return _singleton;
  }

  AppColor._internal();

// Light Theme Colors
  static Color primary = const Color(0xFF6200EE);
  static Color onPrimary = const Color(0xFFFFFFFF);
  static Color secondary = const Color(0xFFBB86FC);
  static Color onSecondary = const Color(0xFF000000);
  static Color error = const Color(0xFFB00020);
  static Color onError = const Color(0xFFFFFFFF);
  static Color background = const Color(0xFFFFFFFF);
  static Color onBackground = const Color(0xFF000000);
  static Color surface = const Color(0xFFFFFFFF);
  static Color onSurface = const Color(0xFF000000);
  static Color tertiary = const Color(0xFF4CAF50);
  static Color onTertiary = const Color(0xFFFFFFFF);

// Dark Theme Colors
  static Color darkPrimary = const Color(0xFF6200EE);
  static Color darkOnPrimary = const Color(0xFFFFFFFF);
  static Color darkSecondary = const Color(0xFFBB86FC);
  static Color darkOnSecondary = const Color(0xFF000000);
  static Color darkError = const Color(0xFFCF6679);
  static Color darkOnError = const Color(0xFFFFFFFF);
  static Color darkBackground = const Color(0xFF121212);
  static Color darkOnBackground = const Color(0xFFFFFFFF);
  static Color darkSurface = const Color(0xFF1E1E1E);
  static Color darkOnSurface = const Color(0xFFFFFFFF);
  static Color darkTertiary = const Color(0xFF4CAF50);
  static Color darkOnTertiary = const Color(0xFFFFFFFF);
}
