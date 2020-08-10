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

/// Main Flutter app widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SharedPreferencesBuilder<String>(
      // Theme preferences loading from shared prefs
      pref: 'theme',
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ThemeData initTheme;
          String themeCode;
          if (!snapshot.hasData) {
            // If there is no theme selected, app will use system settings
            final isPlatformDark =
                WidgetsBinding.instance.window.platformBrightness ==
                    Brightness.dark;
            themeCode = isPlatformDark ? 'dark' : 'light';
          } else {
            // Else app will use stored value
            themeCode = snapshot.data;
          }
          initTheme = themes[themeCode];

          return ThemeProvider(
            // For theme changing
            initTheme: initTheme,
            child: Builder(builder: (context) {
              return ChangeNotifierProvider(
                // For provider (now provider is used for buttons theme)
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
