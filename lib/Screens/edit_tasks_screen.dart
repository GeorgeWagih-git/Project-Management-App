import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/tasks_list_view.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class EditTasksScreen extends StatefulWidget {
  const EditTasksScreen({super.key});

  @override
  State<EditTasksScreen> createState() => _EditTasksScreenState();
}

class _EditTasksScreenState extends State<EditTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showappbar: true,
        screenName: 'Edit Tasks',
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 12, 12, 0),
          child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
            TaskListView(
              showremoveicon: true,
              showrenameicon: true,
            ),
          ]),
        ));
  }
}
