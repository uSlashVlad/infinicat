import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinicat/services/prefs.dart';
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

  String typeValue;

  @override
  void initState() {
    super.initState();
  }

  void asyncInit() {
    setState(() async {
      typeValue = await loadString(kPreferenceKeys['image_type']);
      if (typeValue == '') typeValue = 'jpg,png,gif';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SettingsTileButton(
            onPressed: null,
            icon: Icons.palette,
            header: 'Themes',
            description: 'Work in progress',
          ),
          SettingsTileDropdown(
            onChanged: (newValue) {
              setState(() {
                typeValue = newValue;
                saveString(kPreferenceKeys['image_type'], newValue);
              });
            },
            value: typeValue,
            items: {
              'jpg,png,gif': 'Photos and GIFs',
              'jpg,png': 'Photos',
              'gif': 'GIFs',
            },
            icon: Icons.image,
            header: 'Images type',
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
