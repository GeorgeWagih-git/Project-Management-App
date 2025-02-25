import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/tasks_list.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: tasksList.length,
            // ignore: non_constant_identifier_names
            (context, Index) {
      return tasksList[Index];
    }));
  }
}
