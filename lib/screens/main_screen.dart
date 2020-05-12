import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {

  static String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Do'),
        centerTitle: true,
      ),
      body: Container(
        child: Text('Hell yeah brotha man guy the third'),
      ),
    );
  }
}