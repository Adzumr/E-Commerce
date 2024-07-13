import 'package:flutter/material.dart';

/// Singleton class for managing application colors.
class AppColor {
  static final AppColor _singleton = AppColor._internal();

  factory AppColor() {
    return _singleton;
  }

  AppColor._internal();

  // Light Theme Colors

  /// Primary color in the light theme.
  static Color primary = const Color(0xFF6200EE);

  /// Color of content on the primary color in the light theme.
  static Color onPrimary = const Color(0xFFFFFFFF);

  /// Secondary color in the light theme.
  static Color secondary = const Color(0xFFBB86FC);

  /// Color of content on the secondary color in the light theme.
  static Color onSecondary = const Color(0xFF000000);

  /// Error color in the light theme.
  static Color error = const Color(0xFFB00020);

  /// Color of content on the error color in the light theme.
  static Color onError = const Color(0xFFFFFFFF);

  /// Background color in the light theme.
  static Color background = const Color(0xFFFFFFFF);

  /// Color of content on the background color in the light theme.
  static Color onBackground = const Color(0xFF000000);

  /// Surface color in the light theme.
  static Color surface = const Color(0xFFFFFFFF);

  /// Color of content on the surface color in the light theme.
  static Color onSurface = const Color(0xFF000000);

  /// Tertiary color in the light theme.
  static Color tertiary = const Color(0xFF4CAF50);

  /// Color of content on the tertiary color in the light theme.
  static Color onTertiary = const Color(0xFFFFFFFF);

  // Dark Theme Colors

  /// Primary color in the dark theme.
  static Color darkPrimary = const Color(0xFF6200EE);

  /// Color of content on the primary color in the dark theme.
  static Color darkOnPrimary = const Color(0xFFFFFFFF);

  /// Secondary color in the dark theme.
  static Color darkSecondary = const Color(0xFFBB86FC);

  /// Color of content on the secondary color in the dark theme.
  static Color darkOnSecondary = const Color(0xFF000000);

  /// Error color in the dark theme.
  static Color darkError = const Color(0xFFCF6679);

  /// Color of content on the error color in the dark theme.
  static Color darkOnError = const Color(0xFFFFFFFF);

  /// Background color in the dark theme.
  static Color darkBackground = const Color(0xFF121212);

  /// Color of content on the background color in the dark theme.
  static Color darkOnBackground = const Color(0xFFFFFFFF);

  /// Surface color in the dark theme.
  static Color darkSurface = const Color(0xFF1E1E1E);

  /// Color of content on the surface color in the dark theme.
  static Color darkOnSurface = const Color(0xFFFFFFFF);

  /// Tertiary color in the dark theme.
  static Color darkTertiary = const Color(0xFF4CAF50);

  /// Color of content on the tertiary color in the dark theme.
  static Color darkOnTertiary = const Color(0xFFFFFFFF);
}
