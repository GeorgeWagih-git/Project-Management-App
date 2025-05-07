import 'package:flutter_application_1/Classes/project_class.dart';

abstract class OngoingProjectStates {}

class OngoingInitialState extends OngoingProjectStates {}

class OngoingLoadingState extends OngoingProjectStates {}

class OngoingErrorState extends OngoingProjectStates {
  final String errMessege;

  OngoingErrorState({required this.errMessege});
}

class OngoingSuccessfulState extends OngoingProjectStates {
  final List<ProjectClass> project;

  OngoingSuccessfulState({required this.project});
}

class CompleteduccessfulState extends OngoingProjectStates {
  final List<ProjectClass> completedproject;

  CompleteduccessfulState({required this.completedproject});
}

class OngoingAddTaskIntoProjectSuccessfulState extends OngoingProjectStates {
  final ProjectClass project;

  OngoingAddTaskIntoProjectSuccessfulState({required this.project});
}
