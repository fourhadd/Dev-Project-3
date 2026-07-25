// features/settings/presentation/cubit/settings_state.dart
import 'package:flutter/material.dart';

class SettingsState {
  final bool isNotificationsEnabled;
  final ThemeMode themeMode;
  final double fontSizeScale;

  const SettingsState({
    required this.isNotificationsEnabled,
    required this.themeMode,
    required this.fontSizeScale,
  });

  bool get isDarkMode => themeMode == ThemeMode.dark;

  factory SettingsState.initial() {
    return const SettingsState(
      isNotificationsEnabled: true,
      themeMode: ThemeMode.light,
      fontSizeScale: 1.0,
    );
  }

  SettingsState copyWith({
    bool? isNotificationsEnabled,
    ThemeMode? themeMode,
    double? fontSizeScale,
  }) {
    return SettingsState(
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
      themeMode: themeMode ?? this.themeMode,
      fontSizeScale: fontSizeScale ?? this.fontSizeScale,
    );
  }
}
