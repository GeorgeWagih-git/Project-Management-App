import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OngoingProjectCubit extends Cubit<OngoingProjectStates> {
  OngoingProjectCubit(this.api) : super(ProjectsInitialState());
  static OngoingProjectCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final ApiConsumer api;

  UserModel? userModel;

  TextEditingController confirmPassword = TextEditingController();
  final TextEditingController projectControllername = TextEditingController();

  final TextEditingController projectControllerDiscription =
      TextEditingController();
  final TextEditingController projectControllerdayDead =
      TextEditingController();
  final TextEditingController projectControllermonthDead =
      TextEditingController();
  final TextEditingController projectControlleryearDead =
      TextEditingController();
  final GlobalKey<FormState> ongoingFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> projectDetailsScreenFormKey =
      GlobalKey<FormState>();

  final TextEditingController projectController = TextEditingController();

  final TextEditingController tasKTitle = TextEditingController();
  final TextEditingController tasKdescription = TextEditingController();
  final TextEditingController tasKDay = TextEditingController();
  final TextEditingController tasKMonth = TextEditingController();
  final TextEditingController tasKYear = TextEditingController();
  final TextEditingController tasKAssignedTo = TextEditingController();

  final TextEditingController description = TextEditingController();
  List<ProjectClass> projects = [];
  List<ProjectClass> completedprojects = [];
  int completedPercentage(ProjectClass model) {
    if (model.tasks.isEmpty) {
      return 0;
    }
    int completed = model.tasks.where((task) => task.isDone).length;
    int finalnum = ((completed / model.tasks.length) * 100).toInt();
    emit(ProjectsSuccessfulState(project: projects));

    return finalnum;
  }

  void editProjectDescription(
      {required ProjectClass model, required String newDescription}) {
    model.projectDetails = newDescription;
    emit(ProjectsSuccessfulState(project: projects));
  }

  void transformProject(ProjectClass model) {
    if (completedPercentage(model) == 100) {
      deleteProjects(model);
      addCompletedProjects(model);
    }
    if (completedprojects.contains(model) && completedPercentage(model) < 100) {
      deleteCompletedProjects(model);
      transformOngingProjects(model);
    }
    emit(CompletedProjectsuccessfulState(completedproject: completedprojects));
  }

  void getProjects() {
    emit(ProjectsSuccessfulState(project: projects));
  }

  void deleteProjects(ProjectClass model) {
    if (projects.contains(model)) {
      projects.remove(model);
    } else if (completedprojects.contains(model)) {
      completedprojects.remove(model);
    }
    emit(ProjectsSuccessfulState(project: projects));
  }

  void deleteCompletedProjects(ProjectClass model) {
    completedprojects.remove(model);
    emit(ProjectsSuccessfulState(project: projects));
  }

  void renameProject({required ProjectClass model, required String newname}) {
    model.name = newname;
    emit(ProjectsSuccessfulState(project: projects));
  }

  /*void addProjects() {
    var model = ProjectClass(
      tasks: [],
      day: int.parse(projectControllerday.text),
      deadday: int.parse(projectControllerdayDead.text),
      deadmonth: projectControllermonthDead.text,
      deadyear: int.parse(projectControllerdayDead.text),
      month: projectControllermonth.text,
      name: projectControllername.text,
      projectDetails: projectControllerDiscription.text,
      year: int.parse(projectControlleryear.text),
    );
    projects.add(model);
    emit(ProjectsSuccessfulState(project: projects));
  }*/

  void addCompletedProjects(ProjectClass model) {
    if (!completedprojects.contains(model) &&
        completedPercentage(model) == 100) {
      completedprojects.add(model);
      emit(ProjectsSuccessfulState(project: projects));
    }
  }

  void transformOngingProjects(ProjectClass model) {
    if (!projects.contains(model)) {
      projects.add(model);
      emit(ProjectsSuccessfulState(project: projects));
    }
  }

  void editProject(
      {required ProjectClass newModel, required ProjectClass oldModel}) {
    projects.remove(oldModel);
    projects.add(newModel);
    emit(ProjectsSuccessfulState(project: projects));
  }

  // void addTaskIntoProject({required ProjectClass projectRelatedToTask}) {
  //   var task = TaskModel(isDone: false, name: taskController.text);
  //   projectRelatedToTask.tasks.add(task);
  //   emit(
  //     AddTaskIntoProjectSuccessfulState(project: projectRelatedToTask),
  //   );
  //   getProjects();
  // }

  void deleteTaskIntoProject(
      {required TaskModel task, required ProjectClass projectRelatedToTask}) {
    projectRelatedToTask.tasks.remove(task);
    emit(AddTaskIntoProjectSuccessfulState(project: projectRelatedToTask));
  }

  void renameTaskName(
      {required ProjectClass projectRelatedToTask,
      required TaskModel model,
      required String newName}) {
    model.title = newName;
    emit(AddTaskIntoProjectSuccessfulState(project: projectRelatedToTask));
  }

  void editTaskIntoProject(
      {required TaskModel oldTask,
      required TaskModel newTask,
      required ProjectClass projectRelatedToTask}) {
    projectRelatedToTask.tasks.remove(oldTask);
    projectRelatedToTask.tasks.add(newTask);
    emit(AddTaskIntoProjectSuccessfulState(project: projectRelatedToTask));
  }

  /////////////////////////////////////////////////////////////API////////////////////////////////////////////////
  Future<void> createProjectonDatabase({
    required String name,
    required String description,
    required DateTime deadline,
  }) async {
    try {
      emit(ProjectCreateLoading()); // حالة تحميل، اعملها عندك لو مش موجودة

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // final response =
      await api.post(
        Endpoint.createProject,
        data: {
          "name": name,
          "descriptions": description,
          "deadline": deadline.toIso8601String(), // بصيغة JSON
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      await fetchAllProjects(); // ✅ هتجيب أحدث المشاريع بعد الإضافة

      emit(ProjectCreateSuccess());
    } catch (e) {
      emit(ProjectCreateFailure(errMessage: e.toString()));
    }
  }

  Future<void> fetchAllProjects() async {
    try {
      emit(ProjectCreateLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await api.get(
        Endpoint.getallProjects,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print("RESPONSE DATA: $response");

      final List<ProjectClass> fetchedProjects = (response as List)
          .map((item) => ProjectClass.fromJson(item, []))
          .toList();

      projects = fetchedProjects;
      emit(ProjectsSuccessfulState(project: projects));
    } catch (e) {
      emit(ProjectCreateFailure(errMessage: e.toString()));
    }
  }

  ////////////////////////////////////////////////////////////////////////////
  Future<void> createTaskOnServer({
    required String title,
    required String description,
    required DateTime deadline,
    required int projectId,
    required String assignedTo,
  }) async {
    try {
      emit(ProjectCreateLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await api.post(
        Endpoint.createTask,
        data: {
          "title": title,
          "description": description,
          "deadline": deadline.toIso8601String(),
          "projectId": projectId,
          "assignedTo": assignedTo,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      await fetchProjectWithTasks(projectId);
      //emit(ProjectCreateSuccess());
    } catch (e) {
      emit(ProjectCreateFailure(errMessage: e.toString()));
    }
  }

  Future<void> fetchProjectWithTasks(int projectId) async {
    try {
      emit(ProjectCreateLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await api.get(
        '/api/Project/GetOneProject/$projectId',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = response; // ✅ أهم سطر هنا

      final projectJson = data['project'];
      final tasksJson = data['tasks'] as List;

      final project = ProjectClass.fromJson(
        projectJson,
        tasksJson.map((t) => TaskModel.fromJson(t)).toList(),
      );

      emit(SingleProjectFetchedSuccessfully(project: project));
    } catch (e) {
      emit(ProjectCreateFailure(errMessage: e.toString()));
    }
  }

  Future<void> updateProject({
    required int id,
    required String name,
    required String description,
    required DateTime deadline,
  }) async {
    try {
      emit(ProjectCreateLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await api.put(
        '/api/Project/UpdateProject/$id',
        data: {
          "id": id,
          "name": name,
          "descriptions": description,
          "deadline": deadline.toIso8601String(),
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      await fetchProjectWithTasks(id); // ⬅️ للتحديث الفوري

      emit(ProjectCreateSuccess());
    } catch (e) {
      emit(ProjectCreateFailure(errMessage: e.toString()));
    }
  }
}
