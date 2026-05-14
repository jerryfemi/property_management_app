import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends Notifier<ThemeMode> {
  static const _boxName = 'settings';
  static const _themeKey = 'theme_mode';

  late Box _box;

  @override
  ThemeMode build() {
    _box = Hive.box(_boxName);
    final savedMode = _box.get(_themeKey) as String?;
    
    if (savedMode == 'dark') return ThemeMode.dark;
    if (savedMode == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }

  void toggleTheme() {
    final isDark = state == ThemeMode.dark || 
        (state == ThemeMode.system && 
         WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);
         
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    state = newMode;
    _box.put(_themeKey, newMode == ThemeMode.dark ? 'dark' : 'light');
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    final modeStr = mode == ThemeMode.dark ? 'dark' : (mode == ThemeMode.light ? 'light' : 'system');
    _box.put(_themeKey, modeStr);
  }
}
