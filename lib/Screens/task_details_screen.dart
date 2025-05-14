import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/edit_task_button_widget.dart';
import 'package:intl/intl.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({
    super.key,
    required this.taskitem,
    required this.onGoingCubit,
    required this.user,
  });

  final TaskModel taskitem;
  final OngoingProjectCubit onGoingCubit;
  final UserModel user;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  TaskModel? _task;

  @override
  void initState() {
    super.initState();
    _task = widget.taskitem;
  }

  @override
  Widget build(BuildContext context) {
    if (_task == null) {
      return const Center(child: CircularProgressIndicator());
    }
    String formattedDate =
        DateFormat('dd MMM yyyy - h:mm a').format(_task!.deadline);

    return CustomScaffold(
      screenName: 'Task Details',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 12, 12, 0),
        child: RefreshIndicator(
          onRefresh: () async {
            await widget.onGoingCubit.fetchProjectWithTasks(_task!.projectId);
            setState(() {}); // عشان يعيد بناء التفاصيل من جديد لو حصل تعديل
          },
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _task!.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration:
                                const BoxDecoration(color: Color(0xffFED36A)),
                            child: const Icon(Icons.people),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Employee name : ${_task!.assignedTo}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(color: Color(0xffFED36A)),
                            child: Icon(Icons.calendar_month),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dead Date',
                                style: TextStyle(
                                    fontSize: 11, color: Color(0xff8CAAB9)),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Task Details',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Row(
                            children: widget.user.userName == _task!.assignedTo
                                ? [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.white),
                                      onPressed: () async {
                                        final updatedTask =
                                            await showModalBottomSheet<
                                                TaskModel>(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor:
                                              const Color(0xff212832),
                                          builder: (BuildContext context) {
                                            return EditTaskButtonWidget(
                                              task: _task!,
                                              projectId: _task!.projectId,
                                              cubit: widget.onGoingCubit,
                                            );
                                          },
                                        );

                                        if (updatedTask != null) {
                                          setState(() {
                                            _task = updatedTask;
                                          });
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () async {
                                        final confirm = await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Confirm Delete'),
                                            content: const Text(
                                                'Are you sure you want to delete this task?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, true),
                                                child: const Text('Delete'),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          OngoingProjectCubit.get(context)
                                              .deleteTaskFromServer(
                                            taskId: widget.taskitem.id,
                                            projectId:
                                                widget.taskitem.projectId,
                                          );
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                  ]
                                : [],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _task!.description,
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 19),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
