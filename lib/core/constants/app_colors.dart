// core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color readState;
  final Color? divider;

  const AppColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.readState,
    this.divider,
  });

  static const light = AppColors(
    primary: Color(0xFF1A56DB),
    background: Color(0xFFF9FAFB),
    surface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF111827),
    textSecondary: Color(0xFF6B7280),
    readState: Color(0xFFD1D5DB),
    divider: Color(0xFFE5E7EB),
  );

  static const dark = AppColors(
    primary: Color(0xFF3B82F6),
    background: Color(0xFF0B1120),
    surface: Color(0xFF1E293B),
    textPrimary: Color(0xFFF9FAFB),
    textSecondary: Color(0xFF94A3B8),
    readState: Color(0xFF475569),
    divider: Color(0xFF334155),
  );

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? readState,
    Color? divider,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      readState: readState ?? this.readState,
      divider: divider ?? this.divider,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      readState: Color.lerp(readState, other.readState, t)!,
      divider: Color.lerp(divider, other.divider, t),
    );
  }
}

extension AppColorsExtension on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;
}
