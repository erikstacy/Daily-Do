import 'package:daily_do/screens/login_screen.dart';
import 'package:daily_do/services/auth.dart';
import 'package:daily_do/services/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {

  static String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Todo> todoList;

  void onTodoTap(Todo todo, bool newVal) {
    setState(() {
      todo.isDone = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {

    todoList = Provider.of<List<Todo>>(context);

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
                              Todo todo = Todo(title: _textController.text);
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
    return Column(
      children: <Widget>[
        Row(
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
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[900],
        ),
      ],
    );
  }
}