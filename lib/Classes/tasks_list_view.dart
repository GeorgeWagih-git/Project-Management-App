import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/widgets/inline_task_search_bar.dart';
import 'package:flutter_application_1/widgets/task_container_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListview extends StatelessWidget {
  final ProjectClass project;
  final UserModel user;

  const TaskListview({
    super.key,
    required this.project,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
      builder: (context, state) {
        final cubit = OngoingProjectCubit.get(context);
        final tasks = cubit.filteredTasks;

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: InlineTaskSearchBar(projectid: project.id),
                );
              }

              final task = tasks[index - 1];

              return TaskContainerWidget(
                taskitem: task,
                project2: project,
                user: user,
              );
            },
            childCount: tasks.length + 1, // +1 عشان نحجز مكان للسيرش
          ),
        );
      },
    );
  }
}
