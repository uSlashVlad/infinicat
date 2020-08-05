import 'package:flutter/material.dart';

class ProviderModel extends ChangeNotifier {
  ProviderModel(String initTheme) {
    _themeCode = initTheme;
  }

  String _themeCode;

  String get themeCode => _themeCode;
  void setThemeCode(String value) {
    _themeCode = value;
    notifyListeners();
  }
}
