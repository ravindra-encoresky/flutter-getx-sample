class Todo {
  final String title;
  final String description;
  final bool isDone;

  Todo({required this.title, this.description = '', this.isDone = false});

  Todo copyWith({String? title, String? description, bool? isDone}) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
} 