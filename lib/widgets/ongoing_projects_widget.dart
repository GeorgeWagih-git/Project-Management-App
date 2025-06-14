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
    // double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        navigateTo(context, ProjectDetailsScreen(projectClass: projectClass));
      },
      child: BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
        builder: (context, state) {
          String deadDate =
              DateFormat('dd MMM yyyy - h:mm a').format(projectClass.deadline);
          String createdDate = DateFormat('dd MMM yyyy - h:mm a')
              .format(projectClass.createdDate);
          var completedPercentage =
              onGoingCubit.completedPercentage(projectClass);

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff455A64),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        projectClass.name,
                        style: const TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Manager: ${projectClass.Email}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Created: $createdDate',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Deadline: $deadDate',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: CircularPercentIndicator(
                    radius: 45,
                    lineWidth: 6,
                    animation: true,
                    percent: (completedPercentage / 100).clamp(0.0, 1.0),
                    center: Text(
                      "$completedPercentage%",
                      style: const TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    progressColor: Colors.lightBlue,
                    backgroundColor: Colors.white12,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
