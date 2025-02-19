import 'package:flutter_application_1/Classes/task_class.dart';
import 'package:flutter_application_1/widgets/Completed_tasks_widget.dart';

List<CompletedTasksWidget> completedlist = [
  CompletedTasksWidget(
    task_Class: TaskClass(
      name: 'Mobile App Wireframe',
    ),
  ),
  CompletedTasksWidget(
    task_Class: TaskClass(name: 'Read Estate App Design'),
  ),
  CompletedTasksWidget(
    task_Class: TaskClass(name: 'Dashboard & App Design'),
  ),
  CompletedTasksWidget(
    task_Class: TaskClass(name: 'Complete Flutter project'),
  ),
  CompletedTasksWidget(
    task_Class: TaskClass(name: 'Fix bugs in the app'),
  ),
  CompletedTasksWidget(
    task_Class: TaskClass(name: 'Design new UI'),
  ),
  CompletedTasksWidget(
    task_Class: TaskClass(name: 'Test the application'),
  ),
  CompletedTasksWidget(
    task_Class: TaskClass(name: 'Deploy to production'),
  ),
];
