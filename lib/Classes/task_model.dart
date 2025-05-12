class TaskModel {
  int id;
  String title;
  String description;
  DateTime deadline;
  String assignedTo;
  bool isDone;
  int projectId; // 👈 أضف ده

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.assignedTo,
    required this.isDone,
    required this.projectId, // 👈 أضف ده
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
      assignedTo: json['assignedTo'],
      isDone: json['isDone'],
      projectId: json['projectId'], // 👈 تأكد إن ده موجود في الـ API
    );
  }
}
