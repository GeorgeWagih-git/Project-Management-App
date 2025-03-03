import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/widgets/task_container_widget.dart';
import 'package:provider/provider.dart';
import './task_model.dart';

// ignore: must_be_immutable
class TaskListView extends StatelessWidget {
  TaskListView(
      {super.key,
      this.showcheckbox = false,
      this.showremoveicon = false,
      this.showrenameicon = false,
      required this.tasks});
  bool showcheckbox;
  bool showremoveicon;
  bool showrenameicon;
  final List<TaskItem> tasks; // ✅ يستقبل List<TaskItem> بدلاً من TaskModel

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(
      builder: (context, task, child) {
        if (tasks.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                'No Tasks Yet !',
                style: TextStyle(color: Color(0xffFED36A), fontSize: 25),
              ),
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: tasks.length,
              // ignore: non_constant_identifier_names
              (context, Index) {
                return TaskContainerWidget(
                  project: ProjectClass(name: tasks[Index].name),
                  showcheckbox: showcheckbox,
                  showremoveicon: showremoveicon,
                  showrenameicon: showrenameicon,
                  taskitem: tasks[Index],
                );
              },
            ),
          );
        }
      },
    );
  }
}
