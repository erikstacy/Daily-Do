import 'package:daily_do/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Do',
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}