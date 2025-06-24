import 'package:flutter/material.dart';
import 'package:flutter_getx/controllers/todo_controller.dart';
import 'package:get/get.dart';

class DetailView extends StatefulWidget {
  final int index;
  DetailView({super.key, required this.index});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    final todo = Get.find<TodoController>().todos[widget.index];
    _titleController = TextEditingController(text: todo.title);
    _descController = TextEditingController(text: todo.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _save() {
    final controller = Get.find<TodoController>();
    controller.updateTodo(
      widget.index,
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Edit Task'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final todo = controller.todos[widget.index];
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descController,
                minLines: 8,
                maxLines: 20,
                style: theme.textTheme.bodyLarge,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              const SizedBox(height: 24),
              SwitchListTile.adaptive(
                value: todo.isDone,
                onChanged: (_) => controller.toggleTodo(widget.index),
                title: Text(
                  todo.isDone ? 'Completed' : 'Mark as completed',
                  style: theme.textTheme.titleMedium,
                ),
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save_rounded),
                  label: const Text('Update Task'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
} 