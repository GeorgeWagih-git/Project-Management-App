import 'task_model.dart';

class ProjectClass {
  int id; // ✅ رقم المشروع
  String name;
  DateTime deadline;
  String projectDetails;
  bool isSelected = false;
  List<TaskModel> tasks;

  ProjectClass({
    required this.id, // ✅ مطلوب
    required this.tasks,
    required this.deadline,
    required this.name,
    required this.projectDetails,
  });

  ProjectClass copyWith({
    int? id,
    String? name,
    List<TaskModel>? tasks,
    String? projectDetails,
    DateTime? deadline,
  }) {
    return ProjectClass(
      id: id ?? this.id,
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
      projectDetails: projectDetails ?? this.projectDetails,
      deadline: deadline ?? this.deadline,
    );
  }

  factory ProjectClass.fromJson(Map<String, dynamic> json) {
    return ProjectClass(
      id: json['id'], // ✅ جاي من الـ API
      name: json['name'] ?? 'No Name',
      projectDetails: json['descriptions'] ?? 'No Description',
      deadline: DateTime.parse(json['deadline']),
      tasks: [], // هيتملوا لاحقًا لما تجيب الـ Tasks
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'descriptions': projectDetails,
      'deadline': deadline.toIso8601String(),
    };
  }
}
