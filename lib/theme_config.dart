import 'package:flutter/material.dart';

// Base material themes for "Material app"
// All of them are private
final _lightTheme = ThemeData.light().copyWith(
  cardColor: Colors.grey[300],
);

final _darkTheme = ThemeData.dark();

final _pinkTheme = _lightTheme.copyWith(
  accentColor: Color(0xffe5b0ea),
  primaryColor: Color(0xffe5b0ea),
  appBarTheme: AppBarTheme(
      textTheme: TextTheme(headline6: TextStyle(color: Color(0xff494949))),
      iconTheme: IconThemeData(color: Color(0xff494949))),
);

final _monokaiTheme = _darkTheme.copyWith(
  accentColor: Color(0xffffd866),
  scaffoldBackgroundColor: Color(0xff221f22),
  cardColor: Color(0xff2d2a2e),
  appBarTheme: AppBarTheme(color: Color(0xff19181a)),
  textTheme: TextTheme(
    headline1: TextStyle(color: Color(0xFF9E9A9E)),
  ),
);

final _oneDarkTheme = _darkTheme.copyWith(
  accentColor: Color(0xff4d78cc),
  scaffoldBackgroundColor: Color(0xff282c34),
  cardColor: Color(0xff2c313c),
  appBarTheme: AppBarTheme(color: Color(0xff21252b)),
  textTheme: TextTheme(
    headline1: TextStyle(color: Color(0xffabb2bf)),
  ),
);

/// Contains themes
///
/// `light/dark/pink/monokai/onedark`
final Map<String, ThemeData> themes = {
  'light': _lightTheme,
  'dark': _darkTheme,
  'pink': _pinkTheme,
  'monokai': _monokaiTheme,
  'onedark': _oneDarkTheme,
};

// Base buttons colors
// 0 - Text color
// 1 - "Like" button color
// 2 - "Dislike" button color
// 3 - "New image" button color
// 4 - "Download" button color
final List<Color> _defButtonsColors = [
  Colors.white,
  Color(0xff4caf50),
  Color(0xfff44336),
  Color(0xff2196f3),
  Colors.yellow[800],
];

final List<Color> _pastelButtonsColors = [
  Color(0xff494949),
  Color(0xffa4d4ae),
  Color(0xffea9085),
  Color(0xff99d8d0),
  Color(0xfff0dd92),
];

final List<Color> _monokaiButtonsColors = [
  Color(0xff2d2a2e),
  Color(0xffa9dc76),
  Color(0xffff6188),
  Color(0xff78dce8),
  Color(0xfffc9867),
];

final List<Color> _onedarkButtonsColors = [
  Color(0xff21252b),
  Color(0xff98c379),
  Color(0xffe06c75),
  Color(0xff61afef),
  Color(0xffe5c07b),
];

/// Buttons colors
/// - [0] - Text color
/// - [1] - "Like" button color
/// - [2] - "Dislike" button color
/// - [3] - "New image" button color
/// - [4] - "Download" button color
final Map<String, List<Color>> buttonsColors = {
  'light': _defButtonsColors,
  'dark': _defButtonsColors,
  'pink': _pastelButtonsColors,
  'monokai': _monokaiButtonsColors,
  'onedark': _onedarkButtonsColors,
};
