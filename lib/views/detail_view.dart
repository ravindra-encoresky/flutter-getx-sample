import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class DetailView extends StatelessWidget {
  final int index;
  DetailView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    final todo = controller.todos[index];
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Detail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              todo.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Obx(() => CheckboxListTile(
                  title: const Text('Completed'),
                  value: controller.todos[index].isDone,
                  onChanged: (_) => controller.toggleTodo(index),
                )),
          ],
        ),
      ),
    );
  }
} 