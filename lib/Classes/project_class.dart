import 'task_model.dart';

class ProjectClass {
  String name;

  DateTime deadline;

  String projectDetails;
  bool isSelected = false;
  List<TaskModel> tasks;

  ProjectClass({
    required this.tasks,
    required this.deadline,
    String? name,
    String? projectDetails,
  })  : name = name ?? "No Name Added",
        projectDetails = projectDetails ?? "No Discription yet !";

  ProjectClass copyWith({
    String? name,
    List<TaskModel>? tasks,
    String? projectDetails,
    DateTime? deadline,
  }) {
    return ProjectClass(
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
      projectDetails: projectDetails ?? this.projectDetails,
      deadline: deadline ?? this.deadline,
    );
  }

  factory ProjectClass.fromJson(Map<String, dynamic> json) {
    return ProjectClass(
      name: json['name'],
      projectDetails: json['descriptions'],
      deadline: DateTime.parse(json['deadline']),
      tasks: [],
    );
  }
}
