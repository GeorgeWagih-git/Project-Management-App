import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/task_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskContainerWidget extends StatefulWidget {
  const TaskContainerWidget({
    super.key,
    required this.taskitem,
    required this.project2,
    required this.user,
  });

  final TaskModel taskitem;
  final ProjectClass project2;
  final UserModel user;

  @override
  State<TaskContainerWidget> createState() => _TaskContainerWidgetState();
}

class _TaskContainerWidgetState extends State<TaskContainerWidget> {
  @override
  Widget build(BuildContext context) {
    var onGoingCubit = OngoingProjectCubit.get(context);

    return BlocConsumer<OngoingProjectCubit, OngoingProjectStates>(
      listener: (context, state) {
        if (state is StayusChangeFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("This is not your Task"),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailsScreen(
                  projectClass: widget.project2,
                  taskitem: widget.taskitem,
                  onGoingCubit: onGoingCubit,
                  user: widget.user,
                ),
              ),
            );

            await onGoingCubit.fetchProjectWithTasks(widget.project2.id);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff455A64),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title & checkbox
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.taskitem.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Checkbox(
                      activeColor: const Color(0xffFED36A),
                      checkColor: Colors.black,
                      value: widget.taskitem.isDone,
                      onChanged: (bool? value) async {
                        final newValue = value ?? false;

                        setState(() {
                          widget.taskitem.isDone = newValue;
                        });

                        await onGoingCubit.updateTaskStatusOnly(
                          taskId: widget.taskitem.id,
                          isDone: newValue,
                          projectId: widget.project2.id,
                        );
                        await onGoingCubit
                            .fetchProjectWithTasks(widget.project2.id);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                /// Assigned To
                Row(
                  children: [
                    Icon(Icons.person, size: 18, color: Colors.white70),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Employee: ${widget.taskitem.assignedTo}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
