import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode mode = ThemeMode.light;

  Future<void> ChangeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) return;
    appLanguage = newLanguage;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('Language', appLanguage);
    notifyListeners(); // like set stat function
  }

  Future<void> ChangeThemeMode(ThemeMode themeMode) async {
    if (mode == themeMode) return;
    mode = themeMode;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('ThemeMode', mode.name);
    notifyListeners();
  }

  bool isDarkMode() {
    return mode == ThemeMode.dark;
  }

  void loadSettingData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? Mode = sharedPreferences.getString('ThemeMode');
    String? language = sharedPreferences.getString('Language');

    Mode ?? "light";
    mode = (Mode == "dark" ? ThemeMode.dark : ThemeMode.light);

    language ??= 'en';
    appLanguage = language;
  }
}