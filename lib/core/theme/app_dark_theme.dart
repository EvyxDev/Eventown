import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

ThemeData getAppDarkTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.black,
  );
}
