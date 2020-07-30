import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:infinicat/services/prefs.dart';
import 'package:infinicat/widgets/theme_button.dart';
import 'package:infinicat/widgets/settings_ui.dart';
import 'package:infinicat/theme_config.dart';

class ThemesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Themes'),
      ),
      body: ListView(
        children: [
          ThemeSwitcher(
            builder: (context) {
              return SettingsTileButton(
                onPressed: () {
                  final isPlatformDark =
                      WidgetsBinding.instance.window.platformBrightness ==
                          Brightness.dark;
                  ThemeSwitcher.of(context).changeTheme(
                      theme: themes[isPlatformDark ? 'dark' : 'light']);
                  delKey('theme');
                },
                icon: Icons.sync,
                header: 'Automatic theme',
                description: 'Theme of system',
              );
            },
          ),
          ThemeButton(
            themeCode: 'light',
            title: 'Light',
            icon: FontAwesomeIcons.solidSun,
            description: 'Simple light theme',
          ),
          ThemeButton(
            themeCode: 'dark',
            title: 'Dark',
            icon: FontAwesomeIcons.solidMoon,
            description: 'Simple dark theme',
          ),
        ],
      ),
    );
  }
}
