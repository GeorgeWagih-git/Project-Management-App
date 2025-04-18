import 'package:flutter_application_1/Classes/project_class.dart';

abstract class ProjectState {
  final List<ProjectClass> projects;
  const ProjectState(this.projects);
}

class ProjectInitial extends ProjectState {
  ProjectInitial() : super([]);
}

class ProjectLoaded extends ProjectState {
  const ProjectLoaded(List<ProjectClass> projects) : super(projects);
}

class ProjectError extends ProjectState {
  final String message;
  const ProjectError(this.message, List<ProjectClass> projects)
      : super(projects);
}
