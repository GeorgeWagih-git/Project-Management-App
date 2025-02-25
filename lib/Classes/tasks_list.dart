import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/widgets/task_container_widget.dart';

List<TaskContainerWidget> tasksList = [
  TaskContainerWidget(
      taskModel: TaskModel(name: 'User Interviews', isdone: false)),
  TaskContainerWidget(taskModel: TaskModel(name: 'Wireframes', isdone: false)),
  TaskContainerWidget(
      taskModel: TaskModel(name: 'Design System', isdone: false)),
  TaskContainerWidget(
    taskModel: TaskModel(name: 'Icons', isdone: false),
  ),
  TaskContainerWidget(
      taskModel: TaskModel(name: 'User Interviews', isdone: false)),
  TaskContainerWidget(
      taskModel: TaskModel(name: 'User Interviews', isdone: false)),
  TaskContainerWidget(
      taskModel: TaskModel(name: 'User Interviews', isdone: false)),
  TaskContainerWidget(
      taskModel: TaskModel(name: 'User Interviews', isdone: false)),
];
double completedPercentage() {
  int counter = 0;
  for (int i = 0; i < tasksList.length; i++) {
    if (tasksList[i].taskModel.isdone!) {
      counter++;
    }
  }
  return (counter / tasksList.length);
}
