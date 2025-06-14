import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Screens/inside_chat_screen.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/edit_task_button_widget.dart';
import 'package:intl/intl.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({
    super.key,
    required this.taskitem,
    required this.onGoingCubit,
    required this.user,
    required this.projectClass,
  });

  final TaskModel taskitem;
  final OngoingProjectCubit onGoingCubit;
  final UserModel user;
  final ProjectClass projectClass;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TaskModel _task;

  @override
  void initState() {
    super.initState();
    _task = widget.taskitem;
  }

  @override
  Widget build(BuildContext context) {
    final formattedDeadline =
        DateFormat('dd MMM yyyy - h:mm a').format(_task.deadline);
    final formattedCreatedDate =
        DateFormat('dd MMM yyyy - h:mm a').format(_task.createdDate);

    final isManager = widget.user.email == widget.projectClass.Email;

    return CustomScaffoldWidget(
      screenName: 'Task Details',
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.onGoingCubit.fetchProjectWithTasks(_task.projectId);
          setState(() {});
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 12, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _task.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow(
                      icon: Icons.people,
                      label: 'Employee',
                      value: _task.assignedTo,
                      chat: true,
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow(
                      icon: Icons.access_time,
                      label: 'Created At',
                      value: formattedCreatedDate,
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow(
                      icon: Icons.calendar_month,
                      label: 'Deadline',
                      value: formattedDeadline,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Task Details',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        if (isManager) _buildEditDeleteButtons(),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _task.description,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool chat = false,
  }) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xffFED36A),
            shape: BoxShape.rectangle,
          ),
          child: Icon(icon),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff8CAAB9),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        if (chat == true)
          IconButton(
              highlightColor: Colors.amber,
              onPressed: () async {
                final sender = await AppPrefs.getUser();
                if (sender != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InsideChatScreen(
                        senderId: sender.id,
                        receiverEmail: _task.assignedTo,
                      ),
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.messenger,
                color: Colors.white,
              ))
        else
          SizedBox(
            width: 1,
          ),
      ],
    );
  }

  Widget _buildEditDeleteButtons() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () async {
            final updatedTask = await showModalBottomSheet<TaskModel>(
              context: context,
              isScrollControlled: true,
              backgroundColor: const Color(0xff212832),
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.7,
                  minChildSize: 0.4,
                  maxChildSize: 0.95,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: EditTaskButtonWidget(
                        task: _task,
                        projectId: _task.projectId,
                        cubit: widget.onGoingCubit,
                      ),
                    );
                  },
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
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            final confirm = await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Confirm Delete'),
                content:
                    const Text('Are you sure you want to delete this task?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              widget.onGoingCubit.deleteTaskFromServer(
                taskId: _task.id,
                projectId: _task.projectId,
              );
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
