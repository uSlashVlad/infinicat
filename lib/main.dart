import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:provider/provider.dart';
import 'package:infinicat/screens/main_screen.dart';
import 'package:infinicat/screens/settings_screen.dart';
import 'package:infinicat/screens/themes_screen.dart';
import 'package:infinicat/services/prefs.dart';
import 'package:infinicat/theme_config.dart';
import 'package:infinicat/provider_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SharedPreferencesBuilder<String>(
      pref: 'theme',
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ThemeData initTheme;
          String themeCode;
          if (!snapshot.hasData) {
            final isPlatformDark =
                WidgetsBinding.instance.window.platformBrightness ==
                    Brightness.dark;
            themeCode = isPlatformDark ? 'dark' : 'light';
          } else {
            themeCode = snapshot.data;
          }
          initTheme = themes[themeCode];

          return ThemeProvider(
            initTheme: initTheme,
            child: Builder(builder: (context) {
              return ChangeNotifierProvider(
                create: (context) => ProviderModel(themeCode),
                child: MaterialApp(
                  title: 'InfiniCat',
                  theme: ThemeProvider.of(context),
                  initialRoute: '/',
                  routes: {
                    '/': (context) => MainScreen(),
                    '/settings': (context) => SettingsScreen(),
                    '/settings/themes': (context) => ThemesScreen(),
                  },
                ),
              );
            }),
          );
        } else {
          return Container(color: Colors.white);
        }
      },
    );
  }
}
