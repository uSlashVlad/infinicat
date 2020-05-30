import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadString(String key) async {
  final res = (await SharedPreferences.getInstance()).getString(key);
  print('String "$key" loaded: $res');
  return res;
}

Future<bool> saveString(String key, String value) async {
  final res =
      await (await SharedPreferences.getInstance()).setString(key, value);
  print('String "$key" saved with result $res');
  return res;
}

class SharedPreferencesBuilder<T> extends StatelessWidget {
  final String pref;
  final AsyncWidgetBuilder<T> builder;

  const SharedPreferencesBuilder({
    Key key,
    @required this.pref,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: _future(),
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          return this.builder(context, snapshot);
        });
  }

  Future<T> _future() async {
    dynamic res = await (await SharedPreferences.getInstance()).get(pref);
    print('Dynamic loaded: $res by AsyncBuilder');
    return res;
  }
}
