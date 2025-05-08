import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/endpoints.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_application_1/core/functions/upload_image_to_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class OngoingProjectCubit extends Cubit<OngoingProjectStates> {
  OngoingProjectCubit(this.api) : super(ProjectsInitialState());
  static OngoingProjectCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final ApiConsumer api;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  final TextEditingController signInEmail = TextEditingController();
  //Sign in password
  final TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
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
    emit(ProjectsSuccessfulState(project: projects));
  }

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

  void addTaskIntoProject({required ProjectClass projectRelatedToTask}) {
    var task = TaskModel(isDone: false, name: taskController.text);
    projectRelatedToTask.tasks.add(task);
    emit(
      AddTaskIntoProjectSuccessfulState(project: projectRelatedToTask),
    );
    getProjects();
  }

  void deleteTaskIntoProject(
      {required TaskModel task, required ProjectClass projectRelatedToTask}) {
    projectRelatedToTask.tasks.remove(task);
    emit(AddTaskIntoProjectSuccessfulState(project: projectRelatedToTask));
  }

  void renameTaskName(
      {required ProjectClass projectRelatedToTask,
      required TaskModel model,
      required String newName}) {
    model.name = newName;
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
  signIn() async {
    try {
      emit(SignInLoading());
      await api.post(
        Endpoint.signIn,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(errMessage: e.errModel.errorMessage));
    }
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePicture());
  }

  signUp() async {
    try {
      emit(SignUpLoading());
      await api.post(
        Endpoint.signUp,
        isFormData: true,
        data: {
          ApiKey.name: signUpName.text,
          ApiKey.email: signUpEmail.text,
          ApiKey.phone: signUpPhoneNumber.text,
          ApiKey.password: signUpPassword.text,
          ApiKey.confirmPassword: confirmPassword.text,
          ApiKey.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKey.profilePic: await uploadImageToApi(profilePic!),
        },
      );
      emit(SignUpSuccess());
    } on ServerException catch (e) {
      emit(SignUpFailure(errMessage: e.errModel.errorMessage));
    }
  }
}
