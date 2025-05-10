class TaskModel {
  String title;
  String description;
  DateTime deadline;
  int projectId;
  String assignedTo;
  bool isDone; // استخدام محلي فقط لو عايز تتابع الإنجاز

  TaskModel({
    required this.title,
    required this.description,
    required this.deadline,
    required this.projectId,
    required this.assignedTo,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
      projectId: json['projectId'],
      assignedTo: json['assignedTo'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "deadline": deadline.toIso8601String(),
      "projectId": projectId,
      "assignedTo": assignedTo,
    };
  }

  TaskModel copyWith({
    String? title,
    String? description,
    DateTime? deadline,
    int? projectId,
    String? assignedTo,
    bool? isDone,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      projectId: projectId ?? this.projectId,
      assignedTo: assignedTo ?? this.assignedTo,
      isDone: isDone ?? this.isDone,
    );
  }
}
