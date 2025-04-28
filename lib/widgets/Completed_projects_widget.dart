import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';
import 'package:flutter_application_1/core/functions/navigate_to.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CompletedTasksWidget extends StatefulWidget {
  const CompletedTasksWidget({super.key, required this.projectClass});
  final ProjectClass projectClass;
  @override
  State<CompletedTasksWidget> createState() => _CompletedTasksWidgetState();
}

class _CompletedTasksWidgetState extends State<CompletedTasksWidget> {
  get projectClass => null;

  @override
  Widget build(BuildContext context) {
    var onGoingCubit = OngoingProjectCubit.get(context);
    return BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
      builder: (context, state) {
        var completedPercentage =
            onGoingCubit.completedPercentage(widget.projectClass);
        return GestureDetector(
          onTap: () {
            navigateTo(context,
                ProjectDetailsScreen(projectClass: widget.projectClass));
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
                      "Completed",
                      style: TextStyle(
                          color: widget.projectClass.isSelected
                              ? Colors.black
                              : Colors.white,
                          fontSize: 14),
                    ),
                    Text(
                      "${completedPercentage.toString()}%",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
                  builder: (context, state) {
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
                        value: onGoingCubit
                                .completedPercentage(widget.projectClass) /
                            100,
                        // semanticsLabel: onGoingCubit
                        //     .completedPercentage(widget.projectClass)
                        //     .toString(),
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
