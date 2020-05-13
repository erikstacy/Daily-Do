

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_do/services/db.dart';
import 'package:daily_do/services/globals.dart';

class Todo {

  String id;
  Document<Todo> doc;
  String title;
  bool isDone;
  int position;

  Todo({
    this.id,
    this.doc,
    this.title,
    this.isDone,
    this.position,
  });

  factory Todo.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Todo(
      id: data['id'],
      doc: Document<Todo>(path: doc.reference.path),
      title: data['title'],
      isDone: data['isDone'],
      position: data['position'],
    );
  }

  void addToDb() {
    Global.todoCollection.upsert({
      "title": this.title,
      "isDone": false,
      'position': this.position,
    });
  }

  void updateIsDone(bool newVal) {
    this.isDone = newVal;
    Global.completedCollection.upsert({
      'title': this.title,
      'isDone': this.isDone,
    });
    delete();
  }

  void updateTitle(String newVal) {
    this.title = newVal;
    _updateDb();
  }

  void updatePosition(int newPos) {
    this.position = newPos;
    _updateDb();
  }

  void delete() {
    doc.delete();
  }

  void _updateDb() {
    doc.upsert({
      'title': this.title,
      'isDone': this.isDone,
      'position': this.position,
    });
  }
}

class Completed {

  String id;
  Document<Completed> doc;
  String title;
  bool isDone;

  Completed({
    this.id,
    this.doc,
    this.title,
    this.isDone,
  });

  factory Completed.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Completed(
      id: data['id'],
      doc: Document<Completed>(path: doc.reference.path),
      title: data['title'],
      isDone: data['isDone'],
    );
  }

  void updateIsDone(bool newVal) {
    this.isDone = newVal;
    Global.todoCollection.upsert({
      'title': this.title,
      'isDone': this.isDone,
      'position': Global.todoLength,
    });
    delete();
  }

  void delete() {
    doc.delete();
  }
}