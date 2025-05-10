import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/user_model.dart';

abstract class OngoingProjectStates {}

class ProjectsInitialState extends OngoingProjectStates {}

class ProjectsLoadingState extends OngoingProjectStates {}

class ProjectsErrorState extends OngoingProjectStates {
  final String errMessege;

  ProjectsErrorState({required this.errMessege});
}

class ProjectsSuccessfulState extends OngoingProjectStates {
  final List<ProjectClass> project;

  ProjectsSuccessfulState({required this.project});
}

class AddTaskIntoProjectSuccessfulState extends OngoingProjectStates {
  final ProjectClass project;

  AddTaskIntoProjectSuccessfulState({required this.project});
}

//////////////////////////////////////////////////

final class GetUserDatasuccessful extends OngoingProjectStates {
  final UserModel user;

  GetUserDatasuccessful({required this.user});
}

final class GetUserDataLoading extends OngoingProjectStates {}

final class GetUserDataFailure extends OngoingProjectStates {
  final String errMessage;

  GetUserDataFailure({required this.errMessage});
}
///////////////////////////////////////////////

class CompletedProjectsuccessfulState extends OngoingProjectStates {
  final List<ProjectClass> completedproject;

  CompletedProjectsuccessfulState({required this.completedproject});
}
