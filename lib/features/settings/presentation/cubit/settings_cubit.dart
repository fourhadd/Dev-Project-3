// features/settings/presentation/cubit/settings_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetStorage _storage = GetStorage();

  static const String _notifKey = 'notif_enabled';
  static const String _themeKey = 'dark_mode';
  static const String _fontKey = 'font_scale';

  SettingsCubit() : super(SettingsState.initial()) {
    _loadSettings();
  }

  void _loadSettings() {
    final bool notif = _storage.read<bool>(_notifKey) ?? true;
    final bool isDark = _storage.read<bool>(_themeKey) ?? false;
    final double font = _storage.read<double>(_fontKey) ?? 1.0;

    emit(
      SettingsState(
        isNotificationsEnabled: notif,
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        fontSizeScale: font,
      ),
    );
  }

  void toggleNotifications(bool value) {
    _storage.write(_notifKey, value);
    emit(state.copyWith(isNotificationsEnabled: value));
  }

  void toggleTheme(bool isDark) {
    _storage.write(_themeKey, isDark);
    emit(state.copyWith(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }

  void updateFontScale(double value) {
    _storage.write(_fontKey, value);
    emit(state.copyWith(fontSizeScale: value));
  }
}
