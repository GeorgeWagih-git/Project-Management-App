import 'package:flutter_application_1/Classes/project_class.dart';

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

final class ProjectCreateLoading extends OngoingProjectStates {}

final class ProjectCreateSuccess extends OngoingProjectStates {}

final class ProjectCreateFailure extends OngoingProjectStates {
  final String errMessage;

  ProjectCreateFailure({required this.errMessage});
}
///////////////////////////////////////////////

class CompletedProjectsuccessfulState extends OngoingProjectStates {
  final List<ProjectClass> completedproject;

  CompletedProjectsuccessfulState({required this.completedproject});
}

class SingleProjectFetchedSuccessfully extends OngoingProjectStates {
  final ProjectClass project;

  SingleProjectFetchedSuccessfully({required this.project});
}

final class StayusChangeFailure extends OngoingProjectStates {
  final String errMessage;

  StayusChangeFailure({required this.errMessage});
}
