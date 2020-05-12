import 'package:daily_do/services/models.dart';

import 'db.dart';

class Global {

  static final Map models = {
    Todo: (data) => Todo.fromFirestore(data),
  };

  static final UserCollection<Todo> todoCollection = UserCollection<Todo>(path: 'todos');

}