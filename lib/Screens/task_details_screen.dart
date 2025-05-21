import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
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

    final isManager =
        widget.user.userName == widget.projectClass.managerUserName;

    return CustomScaffoldWidget(
      screenName: 'Task Details',
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.onGoingCubit.fetchProjectWithTasks(_task.projectId);
          setState(() {}); // Refresh data if modified
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
                    /// Title
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

                    /// Employee
                    _buildInfoRow(
                      icon: Icons.people,
                      label: 'Employee',
                      value: _task.assignedTo,
                    ),
                    const SizedBox(height: 20),

                    /// Created Date
                    _buildInfoRow(
                      icon: Icons.access_time,
                      label: 'Created At',
                      value: formattedCreatedDate,
                    ),
                    const SizedBox(height: 20),

                    /// Deadline
                    _buildInfoRow(
                      icon: Icons.calendar_month,
                      label: 'Deadline',
                      value: formattedDeadline,
                    ),
                    const SizedBox(height: 30),

                    /// Task Details + Edit/Delete
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

                    /// Description
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
              builder: (context) {
                return EditTaskButtonWidget(
                  task: _task,
                  projectId: _task.projectId,
                  cubit: widget.onGoingCubit,
                );
              },
            );

            if (updatedTask != null) {
              setState(() => _task = updatedTask);
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
