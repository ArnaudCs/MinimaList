import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme_mode');
    
    if (themeString == 'dark') {
      return ThemeMode.dark;
    } else if (themeString == 'light') {
      return ThemeMode.light;
    }
    return ThemeMode.system; // Par défaut
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', theme.toString().split('.').last);
  }
}
