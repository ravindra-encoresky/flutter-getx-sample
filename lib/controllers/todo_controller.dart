import 'package:get/get.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void addTodo(String title) {
    todos.add(Todo(title: title));
  }

  void removeTodo(int index) {
    todos.removeAt(index);
  }

  void toggleTodo(int index) {
    var todo = todos[index];
    todos[index] = todo.copyWith(isDone: !todo.isDone);
  }
} 