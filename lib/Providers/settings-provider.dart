import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String language = 'en';

  void changLanguage(String newLanguage) {
    if (language == newLanguage) return;
    language = newLanguage;

    notifyListeners();
  }
}
