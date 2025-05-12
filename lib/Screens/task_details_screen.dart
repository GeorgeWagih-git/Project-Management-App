import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/edit_task_button_widget.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen(
      {super.key, required this.taskitem, required this.onGoingCubit});
  final TaskModel taskitem;
  final OngoingProjectCubit onGoingCubit;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  void initState() {
    super.initState();
    OngoingProjectCubit.get(context).updateTaskOnServer(
      assignedTo: widget.taskitem.assignedTo,
      deadline: widget.taskitem.deadline,
      description: widget.taskitem.description,
      projectId: widget.taskitem.projectId,
      taskId: widget.taskitem.id,
      title: widget.taskitem.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenName: 'Task Details',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 12, 12, 0),
        child: RefreshIndicator(
          onRefresh: () async {
            await OngoingProjectCubit.get(context).updateTaskOnServer(
              assignedTo: widget.taskitem.assignedTo,
              deadline: widget.taskitem.deadline,
              description: widget.taskitem.description,
              projectId: widget.taskitem.projectId,
              taskId: widget.taskitem.id,
              title: widget.taskitem.title,
            );
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
                              widget.taskitem.title,
                              style: TextStyle(
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
                            decoration: BoxDecoration(color: Color(0xffFED36A)),
                            child: Icon(Icons.people),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Employee name : ${widget.taskitem.assignedTo}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Task Details',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          EditTaskButtonWidget(
                            cubit: widget.onGoingCubit,
                            projectId: widget.taskitem.projectId,
                            task: widget.taskitem,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.taskitem.description,
                        style:
                            TextStyle(color: Color(0xffBCCFD8), fontSize: 19),
                      ),
                      SizedBox(height: 30),
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
