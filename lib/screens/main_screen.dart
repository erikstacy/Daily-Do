import 'package:daily_do/screens/completed_list_screen.dart';
import 'package:daily_do/screens/login_screen.dart';
import 'package:daily_do/screens/settings.dart';
import 'package:daily_do/screens/todo_list_screen.dart';
import 'package:daily_do/screens/todo_screen.dart';
import 'package:daily_do/services/auth.dart';
import 'package:daily_do/services/globals.dart';
import 'package:daily_do/services/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {

  static String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {

  List<Todo> todoList;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if((prefs.getBool('enable_notifications') ?? false)) {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description', importance: Importance.Max, priority: Priority.High, ticker: 'ticker', playSound: false, enableVibration: false);
        var iOSPlatformChannelSpecifics = IOSNotificationDetails(presentSound: false);
        var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        flutterLocalNotificationsPlugin.show(0, '${todoList[0].title}', 'YOU GOT THIS', platformChannelSpecifics,);
      }
    }
  }

  void onTodoTap(Todo todo, bool newVal) {
    setState(() {
      todo.isDone = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {

    todoList = Provider.of<List<Todo>>(context);

    if (todoList != null) {

      todoList.sort((a, b) => a.position.compareTo(b.position));
      Global.todoLength = todoList.length;

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Daily Do'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            _TodoCard(todoList: todoList),
            SizedBox(height: 15,),
            _CompletedCard(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, SettingsScreen.id);
                },
              ),
              ListTile(
                title: Text('Sign out'),
                onTap: () {
                  AuthService().signOut();
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class _TodoCard extends StatelessWidget {

  final List<Todo> todoList;

  _TodoCard({ this.todoList });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, TodoListScreen.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10,),
                  Icon(
                    Icons.check_box_outline_blank,
                    size: 20,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'Todo',
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Text(todoList[0].title),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletedCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CompletedListScreen.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10,),
                  Icon(
                    Icons.check_box,
                    size: 20,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'Completed',
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Text('Check out your completed todos'),
            ),
          ],
        ),
      ),
    );
  }
}