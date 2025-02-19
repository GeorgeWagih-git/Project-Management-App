import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/task_class.dart';
import 'package:flutter_application_1/widgets/ongoing_tasks_widget.dart';

class OngoingTasksList extends StatelessWidget {
  OngoingTasksList({super.key});
  final List<OngoingTasksWidget> ongoinglist = [
    OngoingTasksWidget(
      task_class: TaskClass(name: 'Read Estate App Design'),
    ),
    OngoingTasksWidget(
      task_class: TaskClass(name: 'Dashboard & App Design'),
    ),
    OngoingTasksWidget(
      task_class: TaskClass(name: 'Complete Flutter project'),
    ),
    OngoingTasksWidget(
      task_class: TaskClass(name: 'Fix bugs in the app'),
    ),
    OngoingTasksWidget(
      task_class: TaskClass(name: 'Design new UI'),
    ),
    OngoingTasksWidget(
      task_class: TaskClass(name: 'Test the application'),
    ),
    OngoingTasksWidget(
      task_class: TaskClass(name: 'Deploy to production'),
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
