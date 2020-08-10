import 'package:flutter/material.dart';

/// Simple text object for settings
class SectionTitle extends StatelessWidget {
  SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      child: Text(
        text,
        style: TextStyle(
          color: theme.accentColor,
          fontSize: 16.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
    );
  }
}

/// Usual button for settings that call `onTap` function when you press on it
class SettingsTileButton extends StatelessWidget {
  SettingsTileButton({
    @required this.onTap,
    @required this.icon,
    @required this.header,
    this.description = '',
  });

  final Function onTap;
  final IconData icon;
  final String header, description;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      child: _SettingsTileInner(
        icon: icon,
        header: header,
        description: description,
      ),
    );
  }
}

/// Widget like `SettingsTileButton`, but with dropdown inside
/// instead of `FlatButton`
class SettingsTileDropdown extends StatelessWidget {
  SettingsTileDropdown({
    @required this.onChanged,
    this.value,
    @required this.items,
    @required this.icon,
    @required this.header,
    this.description = '',
  });

  final Function(dynamic newValue) onChanged;
  final dynamic value;
  final Map<dynamic, String> items;
  final IconData icon;
  final String header, description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _SettingsTileInner(
            icon: icon,
            header: header,
            description: description,
          ),
          DropdownButton(
            value: value,
            items: _genDropdownList(items, value),
            onChanged: onChanged,
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(14, 5, 0, 0),
    );
  }
}

// Quite stupid function. I think exists more efficient way of doing this
List<DropdownMenuItem> _genDropdownList(Map<dynamic, String> items,
    [dynamic startVal]) {
  // List of dropdown items that will be returned into `items` property
  List<DropdownMenuItem> resultList = [];
  items.forEach((key, value) {
    // Here function "generates" simple list of dropdown items using `items` map
    resultList.add(DropdownMenuItem(
      value: key,
      child: Row(
        children: <Widget>[
          // If selected item is equal to this item in cycle, it will be checked
          (key == startVal) ? Icon(Icons.check, size: 15) : SizedBox(width: 15),
          SizedBox(width: 4),
          Text(value, style: TextStyle(fontSize: 18)),
        ],
      ),
    ));
  });
  return resultList;
}

/// Widget like `SettingsTileButton`, but with checkbox inside
class SettingsTileCheckbox extends StatelessWidget {
  SettingsTileCheckbox({
    @required this.onChanged,
    @required this.value,
    @required this.icon,
    @required this.header,
    this.description = '',
  });

  final Function(bool newValue) onChanged;
  final dynamic value;
  final IconData icon;
  final String header, description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _SettingsTileInner(
            icon: icon,
            header: header,
            description: description,
          ),
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(14, 5, 0, 0),
    );
  }
}

/// Filling of all this Settings Tile widgets
class _SettingsTileInner extends StatelessWidget {
  _SettingsTileInner({
    @required this.icon,
    @required this.header,
    @required this.description,
  });

  final IconData icon;
  final String header, description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 13,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            size: 26,
            color: theme.accentColor,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                header,
                style: TextStyle(
                  fontSize: 19.0,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 18,
                  color: theme.textTheme.headline1.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
