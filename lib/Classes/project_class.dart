import 'task_model.dart';

class ProjectClass {
  int id;
  String name;
  DateTime deadline;
  String projectDetails;
  bool isSelected = false;
  List<TaskModel> tasks;
  String managerUserName;
  DateTime createdDate;

  ProjectClass({
    required this.id,
    required this.tasks,
    required this.deadline,
    required this.name,
    required this.projectDetails,
    required this.managerUserName,
    required this.createdDate,
  });

  ProjectClass copyWith({
    int? id,
    String? name,
    List<TaskModel>? tasks,
    String? projectDetails,
    DateTime? deadline,
    String? managerUserName,
    DateTime? createdDate,
  }) {
    return ProjectClass(
      id: id ?? this.id,
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
      projectDetails: projectDetails ?? this.projectDetails,
      deadline: deadline ?? this.deadline,
      managerUserName: managerUserName ?? this.managerUserName,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  factory ProjectClass.fromJson(
      Map<String, dynamic> json, List<TaskModel> tasks) {
    print("✅ Loaded project: ${json['name']} with ${tasks.length} tasks");

    return ProjectClass(
      id: json['id'],
      name: json['name'] ?? 'No Name',
      projectDetails: json['descriptions'] ?? 'No Description',
      deadline: DateTime.parse(json['deadline']),
      createdDate: DateTime.parse(json['createdDate']),
      managerUserName: json['managerUserName'] ?? '',
      tasks: tasks,
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
