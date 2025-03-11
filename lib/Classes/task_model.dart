import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';

class TaskModel extends ChangeNotifier {
  ProjectClass project = ProjectClass();

  String name;
  bool isDone = false;

  TaskModel({String? name}) : name = name ?? "No Name Added";

  double completedPercentage() {
    if (project.tasks.isEmpty) return 0;

    int completedTasks = project.tasks.where((task) => task.isDone).length;
    double percentage = completedTasks / project.tasks.length;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners(); // تحديث الواجهة بعد حساب النسبة
    });

    return percentage;
  }
}
