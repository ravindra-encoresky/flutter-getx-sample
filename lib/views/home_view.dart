import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import 'detail_view.dart';

class HomeView extends StatelessWidget {
  final TodoController controller = Get.find();
  final TextEditingController textController = TextEditingController();

  HomeView({super.key});

  void _showAddTodoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'New Task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addTodo(context),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _addTodo(context),
                child: const Text('Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTodo(BuildContext context) {
    if (textController.text.trim().isNotEmpty) {
      controller.addTodo(textController.text.trim());
      textController.clear();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(left: 24, top: 16, bottom: 8),
          child: Text(
            'Tasks',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              letterSpacing: -1.2,
              color: theme.colorScheme.onBackground,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          Expanded(
            child: Obx(() {
              if (controller.todos.isEmpty) {
                return Center(
                  child: Text(
                    'No tasks yet. Add one!',
                    style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: controller.todos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final todo = controller.todos[index];
                  return Dismissible(
                    key: ValueKey(todo.title + todo.isDone.toString() + index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.delete, color: theme.colorScheme.error),
                    ),
                    onDismissed: (_) => controller.removeTodo(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: theme.shadowColor.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        leading: Checkbox(
                          value: todo.isDone,
                          shape: const CircleBorder(),
                          onChanged: (_) => controller.toggleTodo(index),
                        ),
                        title: Text(
                          todo.title,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            decoration: todo.isDone ? TextDecoration.lineThrough : null,
                            color: todo.isDone ? theme.hintColor : theme.colorScheme.onSurface,
                          ),
                        ),
                        onTap: () => Get.to(() => DetailView(index: index)),
                        trailing: AnimatedOpacity(
                          opacity: todo.isDone ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(Icons.check_circle, color: Colors.green),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTodoSheet(context),
        icon: const Icon(Icons.add_task_rounded),
        label: const Text('Add Task'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
} 