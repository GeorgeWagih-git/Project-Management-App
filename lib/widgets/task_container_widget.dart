import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/task_model.dart';

class TaskContainerWidget extends StatefulWidget {
  const TaskContainerWidget({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  State<TaskContainerWidget> createState() => _TaskContainerWidgetState();
}

class _TaskContainerWidgetState extends State<TaskContainerWidget> {
  @override
  Widget build(BuildContext context) {
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
                  widget.taskModel.name!,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Checkbox(
                activeColor: Color(0xffFED36A),
                checkColor: Colors.black,
                value: widget.taskModel.isdone,
                onChanged: (bool? value) {
                  setState(() {
                    widget.taskModel.isdone = value!;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
