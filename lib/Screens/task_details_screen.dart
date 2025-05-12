import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/edit_task_button_widget.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen(
      {super.key, required this.taskitem, required this.onGoingCubit});
  final TaskModel taskitem;
  final OngoingProjectCubit onGoingCubit;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenName: '${taskitem.title} Details',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 12, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      'Employee name : ${taskitem.assignedTo}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
                EditTaskButtonWidget(),
              ],
            ),
            SizedBox(height: 15),
            Text(
              taskitem.description,
              style: TextStyle(color: Color(0xffBCCFD8), fontSize: 19),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
