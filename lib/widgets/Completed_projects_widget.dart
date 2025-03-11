import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CompletedTasksWidget extends StatefulWidget {
  const CompletedTasksWidget({super.key, required this.projectClass});
  final ProjectClass projectClass;
  @override
  State<CompletedTasksWidget> createState() => _CompletedTasksWidgetState();
}

class _CompletedTasksWidgetState extends State<CompletedTasksWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectClass>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            try {
              widget.projectClass.isSelected = true;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProjectDetailsScreen(projectClass: widget.projectClass),
                ),
              ).then((_) {
                if (mounted) {
                  // التأكد أن الودجت لا يزال موجودًا
                  setState(() {
                    widget.projectClass.isSelected = false;
                    value.toggleProjectStatus(widget.projectClass);
                  });
                }
              });
            } catch (e, stacktrace) {
              print("Error: $e");
              print("Stacktrace: $stacktrace");
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: 8),
            width: 183,
            height: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              color: widget.projectClass.isSelected
                  ? Color(0xffFED36A)
                  : Color(0xff455A64),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.projectClass.name,
                  style: TextStyle(
                    color: widget.projectClass.isSelected
                        ? Colors.black
                        : Colors.white,
                    fontSize: 21,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Team members',
                      style: TextStyle(
                          color: widget.projectClass.isSelected
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
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.projectClass.completedPercentage() == 1
                          ? 'Completed'
                          : "Not Completed",
                      style: TextStyle(
                          color: widget.projectClass.isSelected
                              ? Colors.black
                              : Colors.white,
                          fontSize: 11),
                    ),
                    Text(
                      "${(widget.projectClass.completedPercentage() * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                          color: widget.projectClass.isSelected
                              ? Colors.black
                              : Colors.white,
                          fontSize: 11),
                    ),
                  ],
                ),
                Consumer<TaskModel>(
                  builder: (context, model, child) {
                    return Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.transparent,
                      ),
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(25),
                        minHeight: 8,
                        color: widget.projectClass.isSelected
                            ? Colors.black
                            : Color(0xffFED36A),
                        backgroundColor: Colors.transparent,
                        value: widget.projectClass.completedPercentage(),
                        semanticsLabel: ((widget.projectClass
                                            .completedPercentage() *
                                        100) >
                                    0.1 ||
                                (widget.projectClass.completedPercentage() *
                                        100) ==
                                    0.1)
                            ? "${(widget.projectClass.completedPercentage() * 100)}%"
                            : "0%",
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
