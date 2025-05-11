import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/task_details_screen.dart';
import 'package:flutter_application_1/core/functions/navigate_to.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class TaskContainerWidget extends StatefulWidget {
  TaskContainerWidget({
    super.key,
    required this.taskitem,
    required this.project,
    this.showcheckbox = false,
    this.showremoveicon = false,
    this.showrenameicon = false,
  });

  final TaskModel taskitem;
  final ProjectClass project;

  bool showcheckbox;
  bool showremoveicon;
  bool showrenameicon;

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
          onTap: () {
            navigateTo(
                context,
                TaskDetailsScreen(
                  taskitem: widget.taskitem,
                  onGoingCubit: onGoingCubit,
                ));
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
                                      OngoingProjectCubit.get(context)
                                          .deleteTaskIntoProject(
                                              task: widget.taskitem,
                                              projectRelatedToTask:
                                                  widget.project);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      if (widget.showrenameicon)
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Color(0xff212832),
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: Container(
                                      height: 300,
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              'Rename Task Name',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              Navigator.pop(
                                                  context); // إغلاق القائمة
                                            },
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "required";
                                              }
                                              return null;
                                            },
                                            controller:
                                                OngoingProjectCubit.get(context)
                                                    .tasKTitle,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              labelText: "Task new Name ",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                            ),
                                            autofocus: true,
                                          ),
                                          SizedBox(height: 16),
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            color: Color(0xffFED36A),
                                            onPressed: () {
                                              // إضافة المهمة هنا
                                              if (OngoingProjectCubit.get(
                                                      context)
                                                  .tasKTitle
                                                  .text
                                                  .isNotEmpty) {
                                                OngoingProjectCubit.get(context)
                                                    .renameTaskName(
                                                        projectRelatedToTask:
                                                            widget.project,
                                                        model: widget.taskitem,
                                                        newName:
                                                            OngoingProjectCubit
                                                                    .get(
                                                                        context)
                                                                .tasKTitle
                                                                .text);

                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Text('Rename'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
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
