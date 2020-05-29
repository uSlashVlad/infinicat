import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadString(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final res = prefs.getString(key);
  print('String "$key" loaded: $res');
  return res;
}

Future<bool> saveString(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final res = prefs.setString(key, value);
  print('String "$key" saved with result $res');
  return res;
}
