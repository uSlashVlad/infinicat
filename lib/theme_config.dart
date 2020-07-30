import 'package:flutter/material.dart';

final _lightTheme = ThemeData.light().copyWith(
  cardColor: Colors.grey[300],
);

final _darkTheme = ThemeData.dark();

final Map<String, ThemeData> themes = {
  'light': _lightTheme,
  'dark': _darkTheme,
};
