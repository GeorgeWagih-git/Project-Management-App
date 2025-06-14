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
  final TextEditingController projectControllerHourDead =
      TextEditingController();
  final TextEditingController projectControllerMinuteDead =
      TextEditingController();
  String selectedAmPm = 'AM';

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
  TextEditingController taskHourController = TextEditingController();
  TextEditingController taskMinuteController = TextEditingController();
  String taskPeriod = 'AM';

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

  /////////////////////////////////////////////////////////////API////////////////////////////////////////////////
  Future<void> createProjectonDatabase({
    required String name,
    required String description,
    required DateTime deadline,
  }) async {
    try {
      emit(ProjectCreateLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // final response =
      await api.post(
        Endpoint.createProject,
        data: {
          "name": name,
          "descriptions": description,
          "deadline": deadline.toIso8601String(),
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      await fetchAllProjects();

      emit(ProjectsSuccessfulState(project: projects));
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

      List<ProjectClass> allProjects = [];

      for (var item in response) {
        final projectJson = item['project'];
        final tasksJson = item['tasks'] ?? [];

        try {
          final List<TaskModel> parsedTasks = tasksJson
              .map<TaskModel>((task) =>
                  TaskModel.fromJson({...task, 'projectId': projectJson['id']}))
              .toList();

          final project = ProjectClass.fromJson(projectJson, parsedTasks);

          allProjects.add(project);
          print("✅ Project parsed: ${project.name}");
        } catch (e, s) {
          print("❌ Error parsing project: $e");
          print("📍 Stack: $s");
          print("🧪 projectJson: $projectJson");
          print("🧪 tasksJson: $tasksJson");
        }
      }

      projects =
          allProjects.where((p) => completedPercentage(p) < 100).toList();
      completedprojects =
          allProjects.where((p) => completedPercentage(p) == 100).toList();
      print('🟢 All Projects Fetched = ${allProjects.length}');
      print('🟡 Ongoing Projects = ${projects.length}');
      print('🔵 Completed Projects = ${completedprojects.length}');

      filteredProjects = projects;
      filteredCompletedProjects = completedprojects;

      emit(ProjectsSuccessfulState(project: filteredProjects));
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

      final data = response;

      final projectJson = data['project'];
      final tasksJson = data['tasks'] as List;

      final project = ProjectClass.fromJson(
        projectJson,
        tasksJson
            .map((t) => TaskModel.fromJson({...t, 'projectId': projectId}))
            .toList(),
      );
      print(response);
      filteredTasks = project.tasks;
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

      await fetchProjectWithTasks(id);

      emit(ProjectCreateSuccess());
    } catch (e) {
      emit(ProjectCreateFailure(errMessage: e.toString()));
    }
  }

  Future<void> deleteProjectFromServer(int projectId) async {
    try {
      emit(ProjectCreateLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await api.delete(
        '/api/Project/DeleteProject/$projectId',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // تحديث القائمة بعد الحذف
      await fetchAllProjects();

      emit(ProjectCreateSuccess());
    } catch (e) {
      emit(ProjectCreateFailure(errMessage: e.toString()));
    }
  }

  Future<void> updateTaskOnServer({
    required int taskId,
    required String title,
    required String description,
    required String assignedTo,
    required DateTime deadline,
    required int projectId,
  }) async {
    try {
      emit(ProjectCreateLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await api.put(
        '/api/Task/UpdateTask/$taskId',
        data: {
          "id": taskId,
          "title": title,
          "description": description,
          "deadline": deadline.toIso8601String(),
          "assignedTo": assignedTo,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      await fetchProjectWithTasks(projectId);
      emit(ProjectCreateSuccess());
    } catch (e) {
      emit(ProjectCreateFailure(errMessage: e.toString()));
    }
  }

  Future<void> updateTaskStatusOnly({
    required int taskId,
    required bool isDone,
    required int projectId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await api.put(
        '/api/Task/UpdateIsDone/$taskId,$isDone',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      await fetchProjectWithTasks(projectId);
    } catch (e) {
      emit(StayusChangeFailure(errMessage: e.toString()));
    }
  }

  Future<void> deleteTaskFromServer({
    required int taskId,
    required int projectId,
  }) async {
    try {
      emit(ProjectCreateLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await api.delete(
        '/api/Task/DeleteTask/$taskId',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      await fetchProjectWithTasks(projectId);

      emit(ProjectCreateSuccess());
    } catch (e) {
      emit(ProjectCreateFailure(errMessage: e.toString()));
    }
  }

  List<ProjectClass> filteredProjects = [];

  List<ProjectClass> filteredCompletedProjects = [];

  void filterProjects(String query) {
    if (query.isEmpty) {
      filteredProjects = projects;
      filteredCompletedProjects = completedprojects;
    } else {
      filteredProjects = projects
          .where((project) =>
              project.name.toLowerCase().contains(query.toLowerCase()) ||
              project.Email.toLowerCase().contains(query.toLowerCase()) ||
              project.projectDetails
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              project.projectDetails
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();

      filteredCompletedProjects = completedprojects
          .where((project) =>
              project.name.toLowerCase().contains(query.toLowerCase()) ||
              project.Email.toLowerCase().contains(query.toLowerCase()) ||
              project.projectDetails
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              project.projectDetails
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }

    emit(ProjectsSuccessfulState(project: filteredProjects));
  }

  List<TaskModel> filteredTasks = [];
  void filterTasks(String keyword, int projectId) {
    List<ProjectClass> allProjects = projects + completedprojects;
    final targetProject = allProjects.firstWhere((p) => p.id == projectId);
    if (keyword.isEmpty) {
      filteredTasks = targetProject.tasks;
    } else {
      filteredTasks = targetProject.tasks
          .where((task) =>
              task.title.toLowerCase().contains(keyword.toLowerCase()) ||
              task.assignedTo.toLowerCase().contains(keyword.toLowerCase()) ||
              task.description.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    emit(SingleProjectFetchedSuccessfully(project: targetProject));
  }
}
