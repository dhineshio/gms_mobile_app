import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeProvider() {
    final saved = LocalStorageService.savedThemeMode;
    // If the user has never chosen a theme, default to dark.
    _themeMode = saved == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    LocalStorageService.saveThemeMode(mode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  void toggleTheme() {
    setThemeMode(
      _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }
}
