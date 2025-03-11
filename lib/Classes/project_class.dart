import 'package:flutter/material.dart';
import 'task_model.dart';

class ProjectClass extends ChangeNotifier {
  List<ProjectClass> ongoinglist = [];
  List<ProjectClass> completedlist = [];

  String name;
  int day;
  String month;
  bool isSelected = false;
  List<TaskModel> tasks = [];

  ProjectClass({int? day, String? month, String? name})
      : day = day ?? 1,
        month = month ?? "Jan",
        name = name ?? "No Name Added";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectClass &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          completedPercentage() == other.completedPercentage();

  @override
  int get hashCode => name.hashCode ^ completedPercentage().hashCode;

  @override
  String toString() {
    return 'Project(name: $name, progress: ${completedPercentage().toString()})';
  }

  void renameProject(String newName) {
    name = newName;
    notifyListeners();
  }

  void deleteTask(TaskModel task) {
    tasks.remove(task);
    notifyListeners();
  }

  void renameTask(TaskModel task, String newName) {
    task.name = newName;
    notifyListeners();
  }

  double completedPercentage() {
    if (tasks.isEmpty) {
      notifyListeners();
      return 0;
    }
    int completedTasks = tasks.where((task) => task.isDone).length;
    notifyListeners();
    return completedTasks / tasks.length;
  }

  void addTask(TaskModel task) {
    tasks.add(task);
    notifyListeners();
  }

  void toggleTaskStatus(TaskModel task) {
    task.isDone = !task.isDone;
    notifyListeners(); // ✅ تحديث الواجهة بعد تغيير المهمة

    print("📌 تحديث حالة المهمة: ${task.name}, isDone: ${task.isDone}");

    // ✅ استدعاء تحديث حالة المشروع فورًا
    toggleProjectStatus(this);
  }

  void addProject(ProjectClass project) {
    ongoinglist.add(project);
    notifyListeners();
  }

  void deleteProject(ProjectClass project) {
    ongoinglist.remove(project);
    completedlist.remove(project);
    notifyListeners();
  }

  void toggleProjectStatus(ProjectClass project) {
    if (project.completedPercentage() == 1) {
      if (ongoinglist.contains(project)) {
        ongoinglist.remove(project);
        completedlist.add(project);
      }
    }
    if (project.completedPercentage() < 1) {
      if (completedlist.contains(project)) {
        completedlist.remove(project);
        ongoinglist.add(project);
      }
    }
    print(ongoinglist);
    print(completedlist);
    print(ongoinglist);
    print(completedlist);
    notifyListeners();
  }
}
