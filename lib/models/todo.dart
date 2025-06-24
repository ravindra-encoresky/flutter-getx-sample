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

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'isDone': isDone,
  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    isDone: json['isDone'] ?? false,
  );
} 