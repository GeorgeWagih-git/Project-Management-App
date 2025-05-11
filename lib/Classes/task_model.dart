class TaskModel {
  int id;
  String title;
  String description;
  DateTime deadline;
  String assignedTo;
  bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.assignedTo,
    required this.isDone,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
      assignedTo: json['assignedTo'],
      isDone: json['isDone'],
    );
  }
}
