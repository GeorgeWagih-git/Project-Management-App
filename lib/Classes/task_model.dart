import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier {
  List<TaskItem> tasksList = [];

  double completedPercentagewithprovider() {
    if (tasksList.isEmpty) return 0;

    int completedTasks = tasksList.where((task) => task.isdone).length;
    double percentage = completedTasks / tasksList.length;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners(); // تحديث الواجهة بعد حساب النسبة
    });

    return percentage;
  }

  void addTask(TaskItem item) {
    tasksList.add(item);
    notifyListeners(); // تحديث الواجهة بعد الإضافة
  }

  void deleteTask(TaskItem item) {
    tasksList.remove(item);
    notifyListeners();
  }

  void toggleTaskStatus(TaskItem task) {
    task.isdone = !task.isdone;
    notifyListeners();
  }

  void renameTask(TaskItem task, String newName) {
    task.name = newName;
    notifyListeners();
  }
}

class TaskItem {
  String name;
  bool isdone = false;
  TaskItem({required this.name});
}
