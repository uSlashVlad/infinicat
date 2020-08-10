import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Simple data loading from shared prefs
Future<String> loadString(String key) async {
  final res = (await SharedPreferences.getInstance()).getString(key);
  print('String "$key" loaded: $res');
  return res;
}

/// Simple data storing into shared prefs
Future<bool> saveString(String key, String value) async {
  final res =
      await (await SharedPreferences.getInstance()).setString(key, value);
  print('String "$key" saved with result $res');
  return res;
}

/// Simple data removing from shared prefs
Future<bool> delKey(String key) async {
  final res = await (await SharedPreferences.getInstance()).remove(key);
  print('"$key" was deleted with result $res');
  return res;
}

class SharedPreferencesBuilder<T> extends StatelessWidget {
  SharedPreferencesBuilder({
    @required this.pref,
    @required this.builder,
  });

  /// Just the pref key
  final String pref;
  final AsyncWidgetBuilder<T> builder;

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
    print('Pref loaded: $res by AsyncBuilder');
    return res;
  }
}
