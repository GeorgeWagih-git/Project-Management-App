import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/task_details_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class TaskContainerWidget extends StatefulWidget {
  const TaskContainerWidget({
    super.key,
    required this.taskitem,
    required this.project,
  });

  final TaskModel taskitem;
  final ProjectClass project;

  @override
  State<TaskContainerWidget> createState() => _TaskContainerWidgetState();
}

class _TaskContainerWidgetState extends State<TaskContainerWidget> {
  @override
  Widget build(BuildContext context) {
    var onGoingCubit = OngoingProjectCubit.get(context);

    return BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailsScreen(
                  taskitem: widget.taskitem,
                  onGoingCubit: onGoingCubit,
                ),
              ),
            );

            await OngoingProjectCubit.get(context)
                .fetchProjectWithTasks(widget.project.id);
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Color(0xff455A64),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Center(
                      child: Text(
                        widget.taskitem.title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: Color(0xffFED36A),
                          checkColor: Colors.black,
                          value: widget.taskitem.isDone,
                          onChanged: (bool? value) async {
                            final newValue = value ?? false;

                            setState(() {
                              widget.taskitem.isDone = newValue;
                            });

                            await OngoingProjectCubit.get(context)
                                .updateTaskStatusOnly(
                              taskId: widget.taskitem.id,
                              isDone: newValue,
                              projectId: widget.project.id,
                            );
                            await OngoingProjectCubit.get(context)
                                .fetchProjectWithTasks(widget.project.id);
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
