import 'package:daily_do/screens/completed_list_screen.dart';
import 'package:daily_do/screens/login_screen.dart';
import 'package:daily_do/screens/main_screen.dart';
import 'package:daily_do/screens/register_screen.dart';
import 'package:daily_do/screens/settings.dart';
import 'package:daily_do/screens/splash_screen.dart';
import 'package:daily_do/screens/todo_list_screen.dart';
import 'package:daily_do/services/globals.dart';
import 'package:daily_do/services/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Todo>>.value(value: Global.todoCollection.collectionStream),
        StreamProvider<List<Completed>>.value(value: Global.completedCollection.collectionStream),
      ],
      child: MaterialApp(
        title: 'Daily Do',
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          MainScreen.id: (context) => MainScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          TodoListScreen.id: (context) => TodoListScreen(),
          CompletedListScreen.id: (context) => CompletedListScreen(),
        },
        theme: ThemeData.dark(),
      ),
    );
  }
}
