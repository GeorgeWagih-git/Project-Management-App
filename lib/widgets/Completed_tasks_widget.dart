import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/task_class.dart';

class CompletedTasksWidget extends StatefulWidget {
  const CompletedTasksWidget({super.key, required this.task_Class});
  final TaskClass task_Class;
  @override
  State<CompletedTasksWidget> createState() => _CompletedTasksWidgetState();
}

class _CompletedTasksWidgetState extends State<CompletedTasksWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.task_Class.selectedIndex = !widget.task_Class.selectedIndex;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(right: 4),
        width: 183,
        height: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: widget.task_Class.selectedIndex
              ? Color(0xffFED36A)
              : Color(0xff455A64),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.task_Class.name ?? "Unavailable",
              style: TextStyle(
                  color: widget.task_Class.selectedIndex
                      ? Colors.black
                      : Colors.white,
                  fontSize: 21),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Team members',
                  style: TextStyle(
                      color: widget.task_Class.selectedIndex
                          ? Colors.black
                          : Colors.white,
                      fontSize: 11),
                ),
                SizedBox(
                    height: 20,
                    width: 81,
                    child: ListView.builder(
                      //shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          personImages[index],
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: personImages.length,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
