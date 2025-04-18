import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';
import 'package:flutter_application_1/core/functions/navigate_to.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OngoingProjectsWidget extends StatelessWidget {
  const OngoingProjectsWidget({super.key, required this.projectClass});
  final ProjectClass projectClass;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, ProjectDetailsScreen(projectClass: projectClass));
        // try {
        //   widget.projectClass.isSelected = true;

        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           ProjectDetailsScreen(projectClass: widget.projectClass),
        //     ),
        //   ).then((_) {
        //     if (mounted) {
        //       // setState(() {
        //       //   widget.projectClass.isSelected = false;
        //       //   value.toggleProjectStatus(widget.projectClass);
        //       // }); // ✅ تحديث الواجهة عند العودة
        //     }
        //   });
        // } catch (e, stacktrace) {
        //   // ignore: avoid_print
        //   print("Error: $e");
        //   // ignore: avoid_print
        //   print("Stacktrace: $stacktrace");
        // }
      },
      child: BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(left: 12, top: 12),
            decoration: BoxDecoration(
              color: projectClass.isSelected
                  ? Color(0xffFED36A)
                  : Color(0xff455A64),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
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
                        projectClass.name,
                        style: TextStyle(
                          color: projectClass.isSelected
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      Text(
                        'Team members',
                        style: TextStyle(
                          color: projectClass.isSelected
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
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                personImages[index],
                                fit: BoxFit.fill,
                              );
                            },
                            itemCount: personImages.length,
                          ),
                        ),
                      ),
                      Text(
                        'StartUp : ${projectClass.day}/${projectClass.month}/${projectClass.year}',
                        style: TextStyle(
                          color: projectClass.isSelected
                              ? Colors.black
                              : Colors.white,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        'DeadLine : ${projectClass.deadday}/${projectClass.deadmonth}/${projectClass.deadyear}',
                        style: TextStyle(
                          color: projectClass.isSelected
                              ? Colors.black
                              : Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: CircularPercentIndicator(
                      progressColor: projectClass.isSelected
                          ? Colors.black
                          : Color(0xffFED36A),
                      radius: 50,
                      percent:
                          0.0, // widget.projectClass.completedPercentage(),
                      center: Text(
                        "",
                        // "${(widget.projectClass.completedPercentage() * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                          color: projectClass.isSelected
                              ? Colors.black
                              : Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
