import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:infinicat/constants.dart';
import 'package:infinicat/widgets/settings_ui.dart';
import 'package:infinicat/services/prefs.dart';

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
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SettingsTileButton(
            onPressed: () {
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
            onPressed: () => launchURL(kApiReferenceUrl),
            icon: FontAwesomeIcons.cogs,
            header: 'API website',
          ),
          SettingsTileButton(
            onPressed: () => launchURL(kRepositoryUrl),
            icon: FontAwesomeIcons.github,
            header: 'Repository',
          ),
          SettingsTileButton(
            onPressed: () => launchURL(kDiscordUrl),
            icon: FontAwesomeIcons.discord,
            header: 'Discord',
          ),
          SettingsTileButton(
            onPressed: () => launchURL(kTelegramUrl),
            icon: FontAwesomeIcons.telegramPlane,
            header: 'Telegram',
          ),
        ],
      ),
    );
  }
}
