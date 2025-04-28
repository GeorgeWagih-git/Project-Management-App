import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class TaskContainerWidget extends StatefulWidget {
  TaskContainerWidget({
    super.key,
    required this.taskitem,
    required this.project, // ✅ إضافة المشروع كمُعامل إجباري
    this.showcheckbox = false,
    this.showremoveicon = false,
    this.showrenameicon = false,
  });

  final TaskModel taskitem;
  final ProjectClass project; // ✅ تخزين المشروع المرتبط بهذه المهمة

  bool showcheckbox;
  bool showremoveicon;
  bool showrenameicon;

  @override
  State<TaskContainerWidget> createState() => _TaskContainerWidgetState();
}

class _TaskContainerWidgetState extends State<TaskContainerWidget> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
      builder: (context, state) {
        // final projectIndex = state..indexOf(widget.project);
        // final taskIndex = widget.project.tasks.indexOf(widget.taskitem);

        return Padding(
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
                      widget.taskitem.name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                if (widget.showcheckbox)
                  Checkbox(
                    activeColor: Color(0xffFED36A),
                    checkColor: Colors.black,
                    value: widget.taskitem.isDone,
                    onChanged: (bool? value) {
                      widget.taskitem.isDone = value ?? false;

                      OngoingProjectCubit.get(context)
                          .transformProject(widget.project);
                    },
                  ),
                if (widget.showremoveicon)
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text(
                              "Are you sure you want to delete this task?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // context
                                //     .read<ProjectCubit>()
                                //     .deleteTaskFromProject(
                                //       projectIndex,
                                //       widget.taskitem,
                                //     );
                                Navigator.pop(context);
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
