import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/projects_list.dart';

class ProjectClass {
  String? name;
  int? day;
  String? month;
  bool isselected = false;
  ProjectClass({this.day, this.month, required this.name});
}

class ProjectModel extends ChangeNotifier {
  List<ProjectClass> projectssList = [];
  bool isselectedfrommode = false;

  double completedPercentagewithprovider() {
    int counter = 0;
    for (int i = 0; i < projectssList.length; i++) {
      if (projectssList[i].isselected) {
        counter++;
      }
    }
    return (counter / projectssList.length);
  }

  void add(ProjectClass item) {
    projectssList.add(item);
    notifyListeners();
  }

  void delete(ProjectClass item) {
    projectssList.remove(item);
    notifyListeners();
  }

  void toggleTaskStatus(ProjectClass task) {
    for (int i = 0; i < completedlist.length; i++) {
      if (completedlist[i].projectClass.isselected) {
        completedlist[i].projectClass.isselected = false;
      }
    }
    task.isselected = true; // عكس الحالة
    notifyListeners();
  }

  void renameTask(ProjectClass task, String newName) {
    task.name = newName;
    notifyListeners(); // تحديث الواجهة
  }
}
