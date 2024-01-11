import 'package:flutter/material.dart';

class AppColor {
  static final AppColor _singleton = AppColor._internal();

  factory AppColor() {
    return _singleton;
  }

  AppColor._internal();

  //  Theme Colors
  final Color primary = const Color(0xFF6B4EFF);
  final Color onPrimary = const Color(0xFFFFFFFF);
  final Color secondary = const Color(0xFFC6C4FF);
  final Color onSecondary = const Color(0xFF000000);
  final Color error = const Color(0xFFB00020);
  final Color onError = const Color(0xFFFFFFFF);
  final Color background = const Color(0xFFFFFFFF);
  final Color blackColor = const Color(0xFF000000);
  final Color onSurface = const Color(0xFF000000);
  final Color tertiary = Colors.green;
  final Color onTertiary = const Color(0xFFFFFFFF);

  // Dark Theme Colors
  final Color darkPrimary = const Color(0xFF6B4EFF);
  final Color darkOnPrimary = const Color(0xFFFFFFFF);
  final Color darkSecondary = const Color(0xFFC6C4FF);
  final Color darkOnSecondary = const Color(0xFF000000);
  final Color darkError = const Color(0xFFB00020);
  final Color darkOnError = const Color(0xFFFFFFFF);
  final Color darkBackground = const Color(0x12121212);
  final Color whiteColor = const Color(0xFFFFFFFF);
  final Color darkOnSurface = const Color(0xFFFFFFFF);
  final Color darkTertiary = Colors.green;
  final Color darkOnTertiary = const Color(0xFFFFFFFF);
}
