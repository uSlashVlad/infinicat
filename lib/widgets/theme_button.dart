import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:infinicat/widgets/settings_ui.dart';
import 'package:infinicat/theme_config.dart';
import 'package:infinicat/services/prefs.dart';

class ThemeButton extends StatelessWidget {
  ThemeButton({
    @required this.themeCode,
    @required this.title,
    this.description,
    @required this.icon,
  });

  final String title, description, themeCode;
  final IconData icon;

  void changeTheme (BuildContext context) {
    if (ThemeProvider.of(context) != themes[themeCode]) {
      ThemeSwitcher.of(context).changeTheme(theme: themes[themeCode]);
    }
    saveString('theme', themeCode);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher(
      builder: (context) {
        return SettingsTileButton(
          onPressed: () => changeTheme(context),
          icon: icon,
          header: title,
          description: description,
        );
      },
    );
  }
}
