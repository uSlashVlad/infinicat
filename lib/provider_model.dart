import 'package:flutter/material.dart';

/// Simple class with the only one property that controll buttons theme.
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
