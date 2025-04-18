// import 'package:flutter_application_1/Classes/project_class.dart';
// import 'package:flutter_application_1/Classes/task_model.dart';
// import 'package:flutter_application_1/Cubits/project_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProjectCubit extends Cubit<ProjectState> {
//   ProjectCubit() : super(ProjectInitial());

//   void loadProjects(List<ProjectClass> projects) {
//     emit(ProjectLoaded(projects));
//   }

//   void addProject(ProjectClass project) {
//     if (state is ProjectLoaded) {
//       final updatedProjects =
//           List<ProjectClass>.from((state as ProjectLoaded).projects)
//             ..add(project);
//       emit(ProjectLoaded(updatedProjects));
//     }
//   }

//   void deleteProject(ProjectClass project) {
//     if (state is ProjectLoaded) {
//       final updatedProjects =
//           List<ProjectClass>.from((state as ProjectLoaded).projects)
//             ..remove(project);
//       emit(ProjectLoaded(updatedProjects));
//     }
//   }

//   void renameProject(int index, String newName) {
//     if (state is ProjectLoaded) {
//       final updatedProjects =
//           List<ProjectClass>.from((state as ProjectLoaded).projects);
//       updatedProjects[index] = ProjectClass(
//         name: newName,
//         tasks: updatedProjects[index].tasks,
//       );
//       emit(ProjectLoaded(updatedProjects));
//     }
//   }

//   void editProjectDetails(int index, String newDetails) {
//     if (state is ProjectLoaded) {
//       final updatedProjects =
//           List<ProjectClass>.from((state as ProjectLoaded).projects);
//       updatedProjects[index] = ProjectClass(
//         name: updatedProjects[index].name,
//         tasks: updatedProjects[index].tasks,
//         projectDetails: newDetails,
//       );
//       emit(ProjectLoaded(updatedProjects));
//     }
//   }

//   void addTaskToProject(ProjectClass project, TaskModel task) {
//     if (state is ProjectLoaded) {
//       final currentState = state as ProjectLoaded;

//       // إنشاء نسخة جديدة من القائمة
//       final updatedProjects = List<ProjectClass>.from(currentState.projects);

//       // البحث عن المشروع المطلوب
//       final projectIndex = updatedProjects.indexOf(project);

//       if (projectIndex != -1) {
//         // إنشاء نسخة جديدة من المهام مع إضافة المهمة الجديدة
//         final updatedTasks =
//             List<TaskModel>.from(updatedProjects[projectIndex].tasks)
//               ..add(task);

//         // إنشاء نسخة جديدة من المشروع مع المهام المحدثة
//         final updatedProject =
//             updatedProjects[projectIndex].copyWith(tasks: updatedTasks);

//         // تحديث القائمة الرئيسية
//         updatedProjects[projectIndex] = updatedProject;

//         // إصدار الحالة الجديدة
//         emit(ProjectLoaded(updatedProjects));
//       }
//     }
//   }

//   void deleteTaskFromProject(int projectIndex, TaskModel task) {
//     if (state is ProjectLoaded) {
//       final updatedProjects =
//           List<ProjectClass>.from((state as ProjectLoaded).projects);
//       updatedProjects[projectIndex].tasks.remove(task);
//       emit(ProjectLoaded(updatedProjects));
//     }
//   }

//   void renameTask(int projectIndex, int taskIndex, String newName) {
//     if (state is ProjectLoaded) {
//       final updatedProjects =
//           List<ProjectClass>.from((state as ProjectLoaded).projects);
//       updatedProjects[projectIndex].tasks[taskIndex].name = newName;
//       emit(ProjectLoaded(updatedProjects));
//     }
//   }

//   void toggleTaskStatus(int projectIndex, int taskIndex) {
//     if (state is ProjectLoaded) {
//       final updatedProjects =
//           List<ProjectClass>.from((state as ProjectLoaded).projects);
//       final updatedTasks =
//           List<TaskModel>.from(updatedProjects[projectIndex].tasks);
//       updatedTasks[taskIndex] = updatedTasks[taskIndex].copyWith(
//         isDone: !updatedTasks[taskIndex].isDone,
//       );
//       updatedProjects[projectIndex] =
//           updatedProjects[projectIndex].copyWith(tasks: updatedTasks);
//       emit(ProjectLoaded(updatedProjects));
//     }
//   }

//   void toggleProjectStatus(int index) {
//     if (state is ProjectLoaded) {
//       final updatedProjects =
//           List<ProjectClass>.from((state as ProjectLoaded).projects);
//       ProjectClass project = updatedProjects[index];

//       double completion = calculateCompletionPercentage(project);
//       if (completion == 1) {
//         updatedProjects.removeAt(index);
//         updatedProjects.insert(0, project);
//       } else {
//         updatedProjects.removeAt(index);
//         updatedProjects.add(project);
//       }
//       emit(ProjectLoaded(updatedProjects));
//     }
//   }

//   // Calculate the completed percentage for a project's tasks
//   double calculateCompletionPercentage(ProjectClass project) {
//     if (project.tasks.isEmpty) {
//       return 0;
//     }
//     int completedTasks = project.tasks.where((task) => task.isDone).length;
//     return completedTasks / project.tasks.length;
//   }
// }
