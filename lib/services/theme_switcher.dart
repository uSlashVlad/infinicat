import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:infinicat/provider_model.dart';
import 'package:infinicat/theme_config.dart';

/// Just changes global material and buttons theme. Why not?
void switchTheme(BuildContext context, String value) {
  ThemeSwitcher.of(context).changeTheme(theme: themes[value]);
  Provider.of<ProviderModel>(context, listen: false).setThemeCode(value);
}
