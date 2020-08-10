import 'package:flutter/material.dart';

/// Simple rounded `FlatButton` with icon and text
class IconicButton extends StatelessWidget {
  IconicButton({
    @required this.icon,
    @required this.text,
    this.color,
    @required this.callback,
    this.textColor,
  });

  final String text;
  final IconData icon;
  final Color color, textColor;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 25.0,
            color: textColor,
          ),
          SizedBox(width: 10),
          Text(
            (text != null) ? text : 'No text',
            style: TextStyle(
              fontSize: 20.0,
              color: textColor,
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: color,
      onPressed: callback,
    );
  }
}
