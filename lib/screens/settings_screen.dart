import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:infinicat/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Main',
            tiles: [
              SettingsTile(
                title: 'Theme',
                subtitle: 'Work in progress',
                leading: Icon(Icons.palette),
                onTap: () {},
              ),
              SettingsTile(
                title: 'Images type',
                subtitle: 'Work in progress',
                leading: Icon(Icons.image),
                onTap: () {},
              ),
              SettingsTile(
                title: 'API settings',
                subtitle: 'Work in progress',
                leading: Icon(Icons.extension),
                onTap: () {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Sources & info',
            tiles: [
              SettingsTile(
                title: 'API reference',
                subtitle: 'Website of Cat API',
                leading: Icon(Icons.language),
                onTap: () => launchURL(kApiReferenceUrl),
              ),
              SettingsTile(
                title: 'GitHub',
                subtitle: 'Project repository',
                leading: Icon(FontAwesomeIcons.github),
                onTap: () => launchURL(kRepositoryUrl),
              ),
              SettingsTile(
                title: 'Telegram',
                subtitle: 'My telegram profile',
                leading: Icon(FontAwesomeIcons.telegram),
                onTap: () => launchURL(kTelegramUrl),
              ),
              SettingsTile(
                title: 'Website',
                subtitle: 'Debils Technologies website',
                leading: Icon(Icons.language),
                onTap: () => launchURL(kWebsiteUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}