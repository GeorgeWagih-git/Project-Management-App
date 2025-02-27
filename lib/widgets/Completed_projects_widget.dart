import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
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
    return Consumer<ProjectModel>(
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            widget.projectClass.isselected = !widget.projectClass.isselected;
            model.toggleTaskStatus(widget.projectClass);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProjectDetailsScreen(projectClass: widget.projectClass),
              ),
            ).then((_) {
              // إعادة التحديد إلى false عند الرجوع
              setState(() {
                widget.projectClass.isselected = false;
              });
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: 4),
            width: 183,
            height: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: widget.projectClass.isselected
                  ? Color(0xffFED36A)
                  : Color(0xff455A64),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.projectClass.name ?? "Unavailable",
                  style: TextStyle(
                      color: widget.projectClass.isselected
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
                          color: widget.projectClass.isselected
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
      },
    );
  }
}
