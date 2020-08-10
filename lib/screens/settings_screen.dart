import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:infinicat/constants.dart';
import 'package:infinicat/widgets/settings_ui.dart';
import 'package:infinicat/services/prefs.dart';

/// Settings screen widget
///
/// `/settings` route
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String typePref;

  @override
  Widget build(BuildContext context) {
    Function(String) callback = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SettingsTileButton(
            onTap: () {
              Navigator.pushNamed(context, '/settings/themes');
            },
            icon: Icons.palette,
            header: 'Themes',
            description: 'Choose theme for you',
          ),
          SharedPreferencesBuilder<String>(
            pref: kPreferenceKeys['image_type'],
            builder: (context, snapshot) {
              if (snapshot.hasData) typePref = snapshot.data;
              return SettingsTileDropdown(
                onChanged: (newValue) {
                  setState(() {
                    saveString(kPreferenceKeys['image_type'], newValue);
                    callback(newValue);
                  });
                },
                value: (snapshot.hasData) ? snapshot.data : 'jpg,png,gif',
                items: {
                  'jpg,png,gif': 'Photos and GIFs',
                  'jpg,png': 'Photos',
                  'gif': 'GIFs',
                },
                icon: Icons.image,
                header: 'Images type',
              );
            },
          ),
          SectionTitle('Sources & Info'),
          SettingsTileButton(
            onTap: () => launchURL(kApiReferenceUrl),
            icon: FontAwesomeIcons.cogs,
            header: 'API website',
          ),
          SettingsTileButton(
            onTap: () => launchURL(kRepositoryUrl),
            icon: FontAwesomeIcons.github,
            header: 'Repository',
          ),
          SettingsTileButton(
            onTap: () => launchURL(kDiscordUrl),
            icon: FontAwesomeIcons.discord,
            header: 'Discord',
          ),
          SettingsTileButton(
            onTap: () => launchURL(kTelegramUrl),
            icon: FontAwesomeIcons.telegramPlane,
            header: 'Telegram',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Infinicat. v1.4.1 (10)',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
