

class Todo {

  String id;
  //Document<User> doc;
  String title;
  bool isDone;

  Todo({
    this.id,
    //this.doc,
    this.title,
    this.isDone,
  });

  /*
  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return User(
      uid: data['uid'],
      doc: Document<User>(path: doc.reference.path),
      email: data['email'],
      lastDay: DateTime.fromMillisecondsSinceEpoch(data['lastDay'].seconds * 1000),
    );
  }
  */
}