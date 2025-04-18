import 'task_model.dart';

class ProjectClass {
  // List<ProjectClass> ongoinglist = [];
  // List<ProjectClass> completedlist = [];

  String name;
  int day;
  String month;
  int year;
  int deadday;
  String deadmonth;
  int deadyear;
  String projectDetails;
  bool isSelected = false;
  List<TaskModel> tasks;

  ProjectClass({
    required this.tasks,
    int? day,
    String? month,
    String? name,
    int? year,
    int? deadday,
    String? deadmonth,
    int? deadyear,
    String? projectDetails,
  })  : day = day ?? DateTime.now().day,
        month = month ?? DateTime.now().month.toString(),
        name = name ?? "No Name Added",
        year = year ?? DateTime.now().year,
        deadday = deadday ?? 1,
        deadmonth = deadmonth ?? "Jan",
        deadyear = deadyear ?? DateTime.now().year,
        projectDetails = projectDetails ?? "No Discription yet !";

  ProjectClass copyWith({
    String? name,
    List<TaskModel>? tasks,
    String? projectDetails,
    int? day,
    String? month,
    int? year,
    int? deadday,
    String? deadmonth,
    int? deadyear,
  }) {
    return ProjectClass(
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
      projectDetails: projectDetails ?? this.projectDetails,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      deadday: deadday ?? this.deadday,
      deadmonth: deadmonth ?? this.deadmonth,
      deadyear: deadyear ?? this.deadyear,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectClass &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Project(name: $name})';
  }

  // void renameProject(String newName) {
  //   name = newName;
  //   notifyListeners();
  // }

  // void editDetails(String newDetails) {
  //   projectDetails = newDetails;
  //   notifyListeners();
  // }

  // void deleteTask(TaskModel task) {
  //   tasks.remove(task);
  //   notifyListeners();
  // }

  // void renameTask(TaskModel task, String newName) {
  //   task.name = newName;
  //   notifyListeners();
  // }

  // double completedPercentage() {
  //   if (tasks.isEmpty) {
  //     notifyListeners();
  //     return 0;
  //   }
  //   int completedTasks = tasks.where((task) => task.isDone).length;
  //   notifyListeners();
  //   return completedTasks / tasks.length;
  // }

  // void addTask(TaskModel task) {
  //   tasks.add(task);
  //   notifyListeners();
  // }

  // void toggleTaskStatus(TaskModel task) {
  //   task.isDone = !task.isDone;
  //   notifyListeners(); // ✅ تحديث الواجهة بعد تغيير المهمة

  //   // ignore: avoid_print
  //   print("📌 تحديث حالة المهمة: ${task.name}, isDone: ${task.isDone}");

  //   // ✅ استدعاء تحديث حالة المشروع فورًا
  //   toggleProjectStatus(this);
  // }

  // void addProject(ProjectClass project) {
  //   ongoinglist.add(project);
  //   notifyListeners();
  // }

  // void deleteProject(ProjectClass project) {
  //   ongoinglist.remove(project);
  //   completedlist.remove(project);
  //   notifyListeners();
  // }

  // void toggleProjectStatus(ProjectClass project) {
  //   if (project.completedPercentage() == 1) {
  //     if (ongoinglist.contains(project)) {
  //       ongoinglist.remove(project);
  //       completedlist.add(project);
  //     }
  //   }
  //   if (project.completedPercentage() < 1) {
  //     if (completedlist.contains(project)) {
  //       completedlist.remove(project);
  //       ongoinglist.add(project);
  //     }
  //   }
  //   // ignore: avoid_print
  //   print(ongoinglist);
  //   // ignore: avoid_print
  //   print(completedlist);
  //   // ignore: avoid_print
  //   print(ongoinglist);
  //   // ignore: avoid_print
  //   print(completedlist);
  //   notifyListeners();
  // }
}
