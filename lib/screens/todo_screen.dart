import 'package:daily_do/services/models.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {

  static String id = 'todo_screen';

  Todo todo;

  TodoScreen({@required this.todo});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.todo.title;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.todo.delete();
              Navigator.pop(context);
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "New Todo",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
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
                  widget.todo.updateTitle(_titleController.text);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}