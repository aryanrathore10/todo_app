class Task {
  final int? id;
  final String title;
  final String description;
  final bool isComplete;
  final DateTime createdAt;

  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.isComplete,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isComplete': isComplete,
      'createdAt': createdAt.toString(),
    };
  }

  static Task fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id'],
        title: data['title'],
        description: data['description'],
        isComplete: data['isComplete']==1,
        createdAt: DateTime.parse(data['createdAt']));
  }
}
