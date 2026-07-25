// core/theme/app_theme.dart
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.light.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.light.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.light.textPrimary),
      ),
      extensions: const <ThemeExtension<dynamic>>[AppColors.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.dark.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.dark.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.dark.textPrimary),
      ),
      extensions: const <ThemeExtension<dynamic>>[AppColors.dark],
    );
  }
}
