import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/widgets/task_container_widget.dart';

class TaskListview extends StatelessWidget {
  final ProjectClass project;

  const TaskListview({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    log("📥 Tasks: ${project.tasks.length}");

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: project.tasks.length,
        (context, index) {
          return TaskContainerWidget(
            taskitem: project.tasks[index],
            project: project,
          );
        },
      ),
    );
  }
}
