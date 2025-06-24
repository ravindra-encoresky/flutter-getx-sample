import 'package:get/get.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void addTodo(String title, {String description = ''}) {
    todos.add(Todo(title: title, description: description));
  }

  void removeTodo(int index) {
    todos.removeAt(index);
  }

  void toggleTodo(int index) {
    var todo = todos[index];
    todos[index] = todo.copyWith(isDone: !todo.isDone);
  }

  void updateTodo(int index, {String? title, String? description}) {
    var todo = todos[index];
    todos[index] = todo.copyWith(title: title, description: description);
  }
} 