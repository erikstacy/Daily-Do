import 'package:daily_do/screens/login_screen.dart';
import 'package:daily_do/screens/settings.dart';
import 'package:daily_do/screens/todo_screen.dart';
import 'package:daily_do/services/auth.dart';
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

      return Scaffold(
        appBar: AppBar(
          title: Text('Daily Do'),
          centerTitle: true,
        ),
        body: Container(
          child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }

              Todo tempTodo = todoList.removeAt(oldIndex);
              todoList.insert(newIndex, tempTodo);

              for (int i = 0; i < todoList.length; i++) {
                todoList[i].updatePosition(i);
              }
            },
            scrollDirection: Axis.vertical,
            children: List.generate(
              todoList.length,
              (index) {
                return _TodoCard(
                  todo: todoList[index],
                  key: Key('$index'),
                );
              }
            ),
          ),
          /*
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return _TodoCard(
                todo: todoList[index],
              );
            },
          ),
          */
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () async {
            TextEditingController _textController = TextEditingController();

            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: TextField(
                            controller: _textController,
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "New Todo",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                Todo todo = Todo(title: _textController.text, position: todoList.length);
                                todo.addToDb();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                );
              }
            );
          },
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

  final Todo todo;
  final VoidCallback onChecked;
  final Key key;

  _TodoCard({
    this.todo,
    this.onChecked,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TodoScreen(todo: todo,)));
          },
          child: Row(
            children: <Widget>[
              Checkbox(
                value: todo.isDone,
                onChanged: (newVal) {
                  todo.updateIsDone(newVal);
                },
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[900],
        ),
      ],
    );
  }
}