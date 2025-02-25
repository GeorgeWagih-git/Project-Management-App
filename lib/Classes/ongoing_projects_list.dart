import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/widgets/ongoing_projects_widget.dart';

class OngoingTasksList extends StatefulWidget {
  OngoingTasksList({super.key});
  int Index = -1;
  @override
  State<OngoingTasksList> createState() => _OngoingTasksListState();
}

class _OngoingTasksListState extends State<OngoingTasksList> {
  final List<OngoingProjectsWidget> ongoinglist = [
    OngoingProjectsWidget(
      selectedIndex: false,
      projectClass: ProjectClass(name: 'Read Estate App Design'),
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Dashboard & App Design'),
      selectedIndex: false,
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Complete Flutter project'),
      selectedIndex: false,
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Fix bugs in the app'),
      selectedIndex: false,
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Design new UI'),
      selectedIndex: false,
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Test the application'),
      selectedIndex: false,
    ),
    OngoingProjectsWidget(
      projectClass: ProjectClass(name: 'Deploy to production'),
      selectedIndex: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: ongoinglist.length,
            (context, Index) {
      return GestureDetector(
          onTap: () {
            setState(() {
              widget.Index = Index;
            });
          },
          child: ongoinglist[Index]..selectedIndex = widget.Index == Index);
    }));
  }
}
