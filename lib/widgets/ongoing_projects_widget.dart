import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';
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
              child: Column(
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
                    'Due on : 20 June',
                    style: TextStyle(
                      color: widget.projectClass.isselected
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
      },
    );
  }
}
