import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/task_class.dart';

class OngoingTasksWidget extends StatefulWidget {
  const OngoingTasksWidget({super.key, required this.task_class});
  final TaskClass task_class;

  @override
  State<OngoingTasksWidget> createState() => _OngoingTasksWidgetState();
}

class _OngoingTasksWidgetState extends State<OngoingTasksWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.task_class.selectedIndex = !widget.task_class.selectedIndex;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 12, top: 12),
        decoration: BoxDecoration(
            color: widget.task_class.selectedIndex
                ? Color(0xffFED36A)
                : Color(0xff455A64),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: 405,
        height: 125,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task_class.name!,
                style: TextStyle(
                  color: widget.task_class.selectedIndex
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              Text(
                'Team members',
                style: TextStyle(
                  color: widget.task_class.selectedIndex
                      ? Colors.black
                      : Colors.white,
                  fontSize: 11,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
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
                    )),
              ),
              Text(
                'Due on : 20 June',
                style: TextStyle(
                  color: widget.task_class.selectedIndex
                      ? Colors.black
                      : Colors.white,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
