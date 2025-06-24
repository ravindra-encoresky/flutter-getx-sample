import 'package:get/get.dart';
import '../models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
    ever(todos, (_) => saveTodos());
  }

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

  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoList = todos.map((t) => t.toJson()).toList();
    prefs.setString('todos', jsonEncode(todoList));
  }

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('todos');
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      todos.value = jsonList.map((e) => Todo.fromJson(e)).toList();
    }
  }
} 