import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/widgets/task_container_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListview extends StatelessWidget {
  final int projectId;
  final bool showcheckboxinlist;
  final bool showremoveiconinlist;
  final bool showrenameiconinlist;

  const TaskListview({
    super.key,
    required this.projectId,
    this.showcheckboxinlist = false,
    this.showremoveiconinlist = false,
    this.showrenameiconinlist = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
      builder: (context, state) {
        if (state is SingleProjectFetchedSuccessfully &&
            state.project.id == projectId) {
          final project = state.project;
          log("📥 Tasks: ${project.tasks.length}");

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: project.tasks.length,
              (context, index) {
                return TaskContainerWidget(
                  showcheckbox: showcheckboxinlist,
                  showremoveicon: showremoveiconinlist,
                  showrenameicon: showrenameiconinlist,
                  taskitem: project.tasks[index],
                  project: project,
                );
              },
            ),
          );
        } else
        //if (state is ProjectCreateLoading)
        {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
          // } else if (state is ProjectCreateFailure) {
          //   return const SliverToBoxAdapter(
          //     child: Center(
          //       child: Text(
          //         'No Tasks Yet !',
          //         style: TextStyle(color: Color(0xffFED36A), fontSize: 25),
          //       ),
          //     ),
          //   );
        }
      },
    );
  }
}
