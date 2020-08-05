import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:infinicat/widgets/settings_ui.dart';
import 'package:infinicat/theme_config.dart';
import 'package:infinicat/services/prefs.dart';
import 'package:infinicat/services/theme_switcher.dart';

class ThemeButton extends StatelessWidget {
  ThemeButton({
    @required this.themeCode,
    @required this.title,
    this.description,
    @required this.icon,
  });

  final String title, description, themeCode;
  final IconData icon;

  void changeTheme(BuildContext context) {
    if (ThemeProvider.of(context) != themes[themeCode]) {
      switchTheme(context, themeCode);
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
