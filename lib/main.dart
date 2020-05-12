import 'package:daily_do/screens/login_screen.dart';
import 'package:daily_do/screens/main_screen.dart';
import 'package:daily_do/screens/register_screen.dart';
import 'package:daily_do/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Do',
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        MainScreen.id: (context) => MainScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}