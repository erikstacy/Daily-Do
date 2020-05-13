import 'package:daily_do/services/models.dart';

import 'db.dart';

class Global {

  static int todoLength;

  static final Map models = {
    Todo: (data) => Todo.fromFirestore(data),
    Completed: (data) => Completed.fromFirestore(data),
  };

  static final UserCollection<Todo> todoCollection = UserCollection<Todo>(path: 'todos');
  static final UserCollection<Completed> completedCollection = UserCollection<Completed>(path: 'completed');

}