// core/theme/theme_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final GetStorage _storage;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this._storage) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final savedTheme = _storage.read<String>(_themeKey);
    if (savedTheme != null) {
      if (savedTheme == 'light') emit(ThemeMode.light);
      if (savedTheme == 'dark') emit(ThemeMode.dark);
      if (savedTheme == 'system') emit(ThemeMode.system);
    }
  }

  void setThemeMode(ThemeMode mode) {
    emit(mode);
    _storage.write(_themeKey, mode.name);
  }
}
