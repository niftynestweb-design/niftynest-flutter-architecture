import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_storage_service.dart';

class ThemeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final storedMode = LocalStorageService.getThemeMode();
    if (storedMode == null) return ThemeMode.dark;
    
    return ThemeMode.values.firstWhere(
      (e) => e.name == storedMode,
      orElse: () => ThemeMode.dark,
    );
  }

  void toggleTheme() {
    final nextMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = nextMode;
    LocalStorageService.setThemeMode(nextMode.name);
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    LocalStorageService.setThemeMode(mode.name);
  }
}

final themeControllerProvider = NotifierProvider<ThemeController, ThemeMode>(() {
  return ThemeController();
});
