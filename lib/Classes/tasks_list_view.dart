import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/widgets/task_container_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class TaskListview extends StatelessWidget {
  TaskListview({
    super.key,
    this.showcheckbox = false,
    this.showremoveicon = false,
    this.showrenameicon = false,
    required this.project,
  });
  bool showcheckbox;
  bool showremoveicon;
  bool showrenameicon;
  ProjectClass project;
  // ✅ يستقبل List<TaskItem> بدلاً من TaskModel
  @override
  Widget build(BuildContext context) {
    log(project.tasks.toString());
    return BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
        builder: (context, state) {
      if (state is OngoingSuccessfulState) {
        log(state.project.toString());
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: project.tasks.length,
            // ignore: non_constant_identifier_names
            (context, Index) {
              return TaskContainerWidget(
                  showcheckbox: true,
                  taskitem: project.tasks[Index],
                  project: project);
            },
          ),
        );
      } else {
        return SliverToBoxAdapter(
          child: Center(
            child: Text(
              'No Tasks Yet !',
              style: TextStyle(color: Color(0xffFED36A), fontSize: 25),
            ),
          ),
        );
      }
    });
  }
}
// TaskContainerWidget(
//                 project: project,
//                 showcheckbox: showcheckbox,
//                 showremoveicon: showremoveicon,
//                 showrenameicon: showrenameicon,
//                 taskitem: project.tasks[Index],
//               );
