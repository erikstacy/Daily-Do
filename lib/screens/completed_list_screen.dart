import 'package:daily_do/screens/login_screen.dart';
import 'package:daily_do/screens/settings.dart';
import 'package:daily_do/screens/todo_list_screen.dart';
import 'package:daily_do/services/auth.dart';
import 'package:daily_do/services/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedListScreen extends StatefulWidget {

  static String id = 'completed_list_screen';

  @override
  _CompletedListScreenState createState() => _CompletedListScreenState();
}

class _CompletedListScreenState extends State<CompletedListScreen> {

  List<Completed> completedList;

  @override
  Widget build(BuildContext context) {

    completedList = Provider.of<List<Completed>>(context);

    if (completedList != null) {

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Todos'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: ListView.builder(
            itemCount: completedList.length,
            itemBuilder: (context, index) {
              return _TodoCard(
                todo: completedList[index],
              );
            },
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

  final Completed todo;
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