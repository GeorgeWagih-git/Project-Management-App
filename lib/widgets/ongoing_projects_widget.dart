import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OngoingProjectsWidget extends StatefulWidget {
  const OngoingProjectsWidget({super.key, required this.projectClass});
  final ProjectClass projectClass;

  @override
  State<OngoingProjectsWidget> createState() => _OngoingProjectsWidgetState();
}

class _OngoingProjectsWidgetState extends State<OngoingProjectsWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectModel>(
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.projectClass.isselected = true; // ✅ يتم التحديد عند النقر
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProjectDetailsScreen(projectClass: widget.projectClass),
              ),
            ).then((_) {
              setState(() {
                widget.projectClass.isselected =
                    false; // ✅ يتم إلغاء التحديد بعد الرجوع
              });
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 12, top: 12),
            decoration: BoxDecoration(
                color: widget.projectClass.isselected
                    ? Color(0xffFED36A)
                    : Color(0xff455A64),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: 405,
            height: 125,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.projectClass.name!,
                        style: TextStyle(
                          color: widget.projectClass.isselected
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      Text(
                        'Team members',
                        style: TextStyle(
                          color: widget.projectClass.isselected
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
                        'Due on : ${widget.projectClass.day} ${widget.projectClass.month}',
                        style: TextStyle(
                          color: widget.projectClass.isselected
                              ? Colors.black
                              : Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Consumer<TaskModel>(
                      builder: (context, model, child) {
                        return CircularPercentIndicator(
                            progressColor: widget.projectClass.isselected
                                ? Colors.black
                                : Color(0xffFED36A),
                            radius: 50,
                            percent: widget.projectClass.completedPercentage(),
                            center: ((widget.projectClass
                                                .completedPercentage() *
                                            100) >
                                        0.1 ||
                                    (widget.projectClass.completedPercentage() *
                                            100) ==
                                        0.1)
                                ? Text(
                                    "${(widget.projectClass.completedPercentage() * 100).toStringAsFixed(0)}%",
                                    style: TextStyle(
                                        color: widget.projectClass.isselected
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 18),
                                  )
                                : Text(
                                    "0%",
                                    style: TextStyle(
                                        color: widget.projectClass.isselected
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 18),
                                  ));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
