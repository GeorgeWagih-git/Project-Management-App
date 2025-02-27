import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/task_container_widget.dart';
import 'package:provider/provider.dart';
import './task_model.dart';

// ignore: must_be_immutable
class TaskListView extends StatelessWidget {
  TaskListView(
      {super.key,
      this.showcheckbox = false,
      this.showremoveicon = false,
      this.showrenameicon = false});
  bool showcheckbox;
  bool showremoveicon;
  bool showrenameicon;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(
      builder: (context, model, child) {
        return SliverList(
            delegate:
                SliverChildBuilderDelegate(childCount: model.tasksList.length,
                    // ignore: non_constant_identifier_names
                    (context, Index) {
          return TaskContainerWidget(
              showcheckbox: showcheckbox,
              showremoveicon: showremoveicon,
              showrenameicon: showrenameicon,
              taskitem: model.tasksList[Index]);
        }));
      },
    );
  }
}
