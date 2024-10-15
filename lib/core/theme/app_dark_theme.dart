import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

ThemeData getAppDarkTheme() {
  return ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      scrolledUnderElevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.black,
    canvasColor: AppColors.primary,
    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.white,
      brightness: Brightness.light,
      onSecondary: AppColors.white,
      error: AppColors.primary,
      onError: AppColors.primary,
      surface: AppColors.white,
      onSurface: AppColors.grey,
    ),
    datePickerTheme: const DatePickerThemeData(
      dayForegroundColor: WidgetStatePropertyAll(AppColors.black),
    ),
  );
}
