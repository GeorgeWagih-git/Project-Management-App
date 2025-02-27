import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier {
  List<TaskItem> tasksList = [
    TaskItem(name: 'First Task'),
  ];

  double completedPercentagewithprovider() {
    int counter = 0;
    for (int i = 0; i < tasksList.length; i++) {
      if (tasksList[i].isdone) {
        counter++;
      }
    }
    return (counter / tasksList.length);
  }

  void add(TaskItem item) {
    tasksList.add(item);
    notifyListeners();
  }

  void delete(TaskItem item) {
    tasksList.remove(item);
    notifyListeners();
  }

  void toggleTaskStatus(TaskItem task) {
    task.isdone = !task.isdone; // عكس الحالة
    notifyListeners();
  }

  void renameTask(TaskItem task, String newName) {
    task.name = newName;
    notifyListeners(); // تحديث الواجهة
  }
}

class TaskItem {
  String name;
  bool isdone = false;
  TaskItem({required this.name});
}
