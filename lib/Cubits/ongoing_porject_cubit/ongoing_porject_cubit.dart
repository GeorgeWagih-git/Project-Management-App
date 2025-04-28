import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngoingProjectCubit extends Cubit<OngoingProjectStates> {
  OngoingProjectCubit() : super(OngoingInitialState());
  static OngoingProjectCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final TextEditingController projectControllername = TextEditingController();
  final TextEditingController projectControllerday = TextEditingController();
  final TextEditingController projectControllermonth = TextEditingController();
  final TextEditingController projectControlleryear = TextEditingController();
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

  final TextEditingController taskController = TextEditingController();

  final TextEditingController description = TextEditingController();
  List<ProjectClass> projects = [];
  List<ProjectClass> completedprojects = [];
  int completedPercentage(ProjectClass model) {
    if (model.tasks.isEmpty) {
      return 0;
    }
    int completed = model.tasks.where((task) => task.isDone).length;
    int finalnum = ((completed / model.tasks.length) * 100).toInt();
    emit(OngoingSuccessfulState(project: projects));

    return finalnum;
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
    emit(CompleteduccessfulState(completedproject: completedprojects));
  }

  void getProjects() {
    emit(OngoingSuccessfulState(project: projects));
  }

  void deleteProjects(ProjectClass model) {
    projects.remove(model);
    emit(OngoingSuccessfulState(project: projects));
  }

  void deleteCompletedProjects(ProjectClass model) {
    completedprojects.remove(model);
    emit(OngoingSuccessfulState(project: projects));
  }

  void addProjects() {
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
    emit(OngoingSuccessfulState(project: projects));
  }

  void addCompletedProjects(ProjectClass model) {
    if (!completedprojects.contains(model) &&
        completedPercentage(model) == 100) {
      completedprojects.add(model);
      emit(OngoingSuccessfulState(project: projects));
    }
  }

  void transformOngingProjects(ProjectClass model) {
    if (!projects.contains(model)) {
      projects.add(model);
      emit(OngoingSuccessfulState(project: projects));
    }
  }

  void editProject(
      {required ProjectClass newModel, required ProjectClass oldModel}) {
    projects.remove(oldModel);
    projects.add(newModel);
    emit(OngoingSuccessfulState(project: projects));
  }

  void addTaskIntoProject({required ProjectClass projectRelatedToTask}) {
    var task = TaskModel(isDone: false, name: taskController.text);
    projectRelatedToTask.tasks.add(task);
    emit(
      OngoingAddTaskIntoProjectSuccessfulState(project: projectRelatedToTask),
    );
    getProjects();
  }

  void deleteTaskIntoProject(
      {required TaskModel task, required ProjectClass projectRelatedToTask}) {
    projectRelatedToTask.tasks.remove(task);
    emit(OngoingAddTaskIntoProjectSuccessfulState(
        project: projectRelatedToTask));
  }

  void editTaskIntoProject(
      {required TaskModel oldTask,
      required TaskModel newTask,
      required ProjectClass projectRelatedToTask}) {
    projectRelatedToTask.tasks.remove(oldTask);
    projectRelatedToTask.tasks.add(newTask);
    emit(OngoingAddTaskIntoProjectSuccessfulState(
        project: projectRelatedToTask));
  }
}
