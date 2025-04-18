import 'package:flutter_application_1/Classes/project_class.dart';

abstract class OngoingProjectStates {}

class OngoingInitialState extends OngoingProjectStates {}

class OngoingLoadingState extends OngoingProjectStates {}

class OngoingErrorState extends OngoingProjectStates {}

class OngoingSuccessfulState extends OngoingProjectStates {
  final List<ProjectClass> project;

  OngoingSuccessfulState({required this.project});
}

class OngoingAddTaskIntoProjectSuccessfulState extends OngoingProjectStates {
  final ProjectClass project;

  OngoingAddTaskIntoProjectSuccessfulState({required this.project});
}
