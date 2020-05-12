import 'package:daily_do/screens/login_screen.dart';
import 'package:daily_do/services/auth.dart';
import 'package:daily_do/services/models.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {

  static String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Todo> todoList = [
    Todo(title: 'Milk sucks', isDone: false),
    Todo(title: 'I eat frogs', isDone: false),
    Todo(title: 'Sometiems the winds is loud', isDone: false),
    Todo(title: 'carrots only good when not bad', isDone: false),
    Todo(title: 'Swing on poles', isDone: false),
  ];

  void onTodoTap(Todo todo, bool newVal) {
    setState(() {
      todo.isDone = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Do'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return _TodoCard(
              todo: todoList[index],
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
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
  }
}

class _TodoCard extends StatelessWidget {

  final Todo todo;
  final VoidCallback onChecked;

  _TodoCard({
    this.todo,
    this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: todo.isDone,
            onChanged: (newVal) {
              // Todo - Make This work
              print(newVal);
            },
          ),
          Text(
            todo.title,
          ),
        ],
      ),
    );
  }
}