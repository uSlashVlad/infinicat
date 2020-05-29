import 'package:flutter/material.dart';

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
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
    );
  }
}

class SettingsTileButton extends StatelessWidget {
  SettingsTileButton({
    @required this.onPressed,
    @required this.icon,
    @required this.header,
    this.description = '',
  });

  final Function onPressed;
  final IconData icon;
  final String header;
  final String description;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: _SettingsTileInner(
        icon: icon,
        header: header,
        description: description,
      ),
    );
  }
}

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
  final String header;
  final String description;

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
            items: genDropdownList(items, value),
            onChanged: onChanged,
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(14, 5, 0, 0),
    );
  }
}

List<DropdownMenuItem> genDropdownList(Map<dynamic, String> items,
    [dynamic startVal]) {
  List<DropdownMenuItem> resultList = [];
  items.forEach((key, value) {
    resultList.add(DropdownMenuItem(
      value: key,
      child: Row(
        children: <Widget>[
          (key == startVal) ? Icon(Icons.check, size: 15) : SizedBox(width: 15),
          SizedBox(width: 4),
          Text(value, style: TextStyle(fontSize: 18)),
        ],
      ),
    ));
  });
  return resultList;
}

class _SettingsTileInner extends StatelessWidget {
  _SettingsTileInner({
    @required this.icon,
    @required this.header,
    @required this.description,
  });

  final IconData icon;
  final String header;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 13,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            size: 30,
            color: theme.accentColor,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                header,
                style: TextStyle(
                  fontSize: 22.5,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                    fontSize: 18, color: theme.textTheme.headline1.color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
