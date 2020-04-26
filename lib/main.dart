import 'package:flutter/material.dart';
import 'package:infinicat/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfiniCat',
      theme: ThemeData.light().copyWith(
        cardColor: Colors.grey[300],
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
      },
    );
  }
}
