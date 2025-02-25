import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/widgets/ongoing_projects_widget.dart';

class OngoingTasksList extends StatelessWidget {
  OngoingTasksList({super.key});
  final List<OngoingProjectsWidget> ongoinglist = [
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Read Estate App Design'),
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Dashboard & App Design'),
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Complete Flutter project'),
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Fix bugs in the app'),
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Design new UI'),
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Test the application'),
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Deploy to production'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: ongoinglist.length,
            (context, Index) {
      return ongoinglist[Index];
    }));
  }
}
