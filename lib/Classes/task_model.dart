import 'package:flutter_application_1/Classes/project_class.dart';

class TaskModel {
  ProjectClass project = ProjectClass(tasks: [], deadline: DateTime.now());

  String name;
  bool isDone;

  TaskModel({String? name, bool? isDone})
      : name = name ?? "No Name Added",
        isDone = isDone ?? false;

  double completedPercentage() {
    if (project.tasks.isEmpty) return 0;

    int completedTasks = project.tasks.where((task) => task.isDone).length;
    double percentage = completedTasks / project.tasks.length;

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   notifyListeners(); // تحديث الواجهة بعد حساب النسبة
    // });

    return percentage;
  }

  TaskModel copyWith({String? name, bool? isDone}) {
    return TaskModel(
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
    );
  }
}
