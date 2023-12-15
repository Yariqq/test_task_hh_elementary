class Task {
  final String title;
  final String description;
  final bool isActive;

  const Task({
    required this.title,
    required this.description,
    required this.isActive,
  });

  Task copyWith({
    String? title,
    String? description,
    bool? isActive,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  const Task.empty()
      : title = '',
        description = '',
        isActive = false;
}
