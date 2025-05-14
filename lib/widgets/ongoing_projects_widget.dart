import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';
import 'package:flutter_application_1/core/functions/navigate_to.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OngoingProjectsWidget extends StatelessWidget {
  const OngoingProjectsWidget({super.key, required this.projectClass});
  final ProjectClass projectClass;

  @override
  Widget build(BuildContext context) {
    var onGoingCubit = OngoingProjectCubit.get(context);
    return BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
        builder: (context, state) {
      var completedPercentage = onGoingCubit.completedPercentage(projectClass);
      return GestureDetector(
        onTap: () {
          navigateTo(context, ProjectDetailsScreen(projectClass: projectClass));
        },
        child: BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
          builder: (context, state) {
            String deadDate = DateFormat('dd MMM yyyy - h:mm a')
                .format(projectClass.deadline);
            String createdDate = DateFormat('dd MMM yyyy - h:mm a')
                .format(projectClass.createdDate);

            return Container(
              margin: EdgeInsets.only(left: 12, top: 12),
              decoration: BoxDecoration(
                color: projectClass.isSelected
                    ? Color(0xffFED36A)
                    : Color(0xff455A64),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: 405,
              height: 150,
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
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Manager :  ${projectClass.managerUserName}',
                          style: TextStyle(
                            color: projectClass.isSelected
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        Text(
                          'Created Date : ${createdDate}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'DeadLine : ${deadDate}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: CircularPercentIndicator(
                        progressColor: Colors.lightBlue,
                        radius: 50,
                        percent: (completedPercentage / 100).toDouble(),
                        center: Text(
                          "${completedPercentage.toString()}%",
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 18),
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
    });
  }
}
