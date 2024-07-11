import 'package:flutter/material.dart';

import 'colors.dart';

class AppColorScheme {
  static AppColorScheme? _instance;

  factory AppColorScheme() {
    _instance ??= AppColorScheme._(); // Create instance if it doesn't exist
    return _instance!;
  }

  AppColorScheme._(); // Private constructor
  ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.primary,
    onPrimary: AppColor.onPrimary,
    secondary: AppColor.secondary,
    onSecondary: AppColor.onSecondary,
    error: AppColor.error,
    onError: AppColor.onError,
    surface: AppColor.onPrimary,
    onSurface: AppColor.onBackground,
    tertiary: AppColor.tertiary,
    onTertiary: AppColor.onTertiary,
  );
  ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColor.darkPrimary,
    onPrimary: AppColor.darkOnPrimary,
    secondary: AppColor.darkSecondary,
    onSecondary: AppColor.darkOnSecondary,
    error: AppColor.darkError,
    onError: AppColor.darkOnError,
    surface: AppColor.darkBackground,
    onSurface: AppColor.darkOnSurface,
    tertiary: AppColor.darkTertiary,
    onTertiary: AppColor.darkOnTertiary,
  );
}
