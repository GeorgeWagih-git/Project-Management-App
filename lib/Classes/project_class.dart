import 'package:flutter/material.dart';
import 'task_model.dart';

class ProjectClass {
  String name;
  int day;
  String month;
  bool isselected = false;
  List<TaskItem> tasks = []; // ✅ كل مشروع لديه قائمة مهامه الخاصة

  ProjectClass({int? day, String? month, required this.name})
      : day = day ?? 1,
        month = month ?? "Jan";
  void renameProject(String newName) {
    name = newName;
  }

  // حساب نسبة المهام المكتملة لهذا المشروع فقط
  double completedPercentage() {
    if (tasks.isEmpty) return 0;
    int completedTasks = tasks.where((task) => task.isdone).length;
    return completedTasks / tasks.length;
  }

  // إضافة مهمة جديدة لهذا المشروع
  void addTask(TaskItem task) {
    tasks.add(task);
  }

  // تحديث حالة المهمة
  void toggleTaskStatus(TaskItem task) {
    task.isdone = !task.isdone;
  }
}

class ProjectModel extends ChangeNotifier {
  List<ProjectClass> completedlist = [];
  List<ProjectClass> ongoinglist = [];

  void addToOngoingList(ProjectClass project) {
    ongoinglist.add(project);
    notifyListeners();
  }

  void deleteFromOngoingList(ProjectClass project) {
    ongoinglist.remove(project);
    notifyListeners();
  }

  void addToCompletedList(ProjectClass project) {
    completedlist.add(project);
    notifyListeners();
  }

  void deleteFromCompletedList(ProjectClass project) {
    completedlist.remove(project);
    notifyListeners();
  }

  void toggleProjectStatus(ProjectClass project) {
    if (completedlist.contains(project) &&
        project.completedPercentage() < 1.0) {
      // 🔄 إذا كان المشروع في قائمة المكتملة وأصبح غير مكتمل، يتم نقله إلى قائمة المشاريع الجارية
      completedlist.remove(project);
      ongoinglist.add(project);
    } else if (ongoinglist.contains(project) &&
        project.completedPercentage() == 1.0) {
      // ✅ إذا كان المشروع جاريًا وأصبح مكتملًا 100%، يتم نقله إلى قائمة المكتملة
      ongoinglist.remove(project);
      completedlist.add(project);
    }

    notifyListeners(); // ✅ تحديث الواجهة بعد التعديل
  }
}
