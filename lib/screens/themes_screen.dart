import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:infinicat/services/prefs.dart';
import 'package:infinicat/widgets/theme_button.dart';
import 'package:infinicat/widgets/settings_ui.dart';
import 'package:infinicat/services/theme_switcher.dart';

class ThemesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Themes',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  switchTheme(context, isPlatformDark ? 'dark' : 'light');
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
          ThemeButton(
            themeCode: 'pink',
            title: 'Pink!',
            icon: FontAwesomeIcons.starHalfAlt,
            description: 'Simple light theme',
          ),
          ThemeButton(
            themeCode: 'monokai',
            title: 'Monokai Pro',
            icon: FontAwesomeIcons.code,
            description: 'My favorite IDE theme',
          ),
          ThemeButton(
            themeCode: 'onedark',
            title: 'One Dark',
            icon: FontAwesomeIcons.atom,
            description: 'Awesome color theme from Atom IDE',
          ),
        ],
      ),
    );
  }
}
