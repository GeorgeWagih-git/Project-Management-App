import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';
import 'package:flutter_application_1/core/functions/navigate_to.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedProjectssWidget extends StatefulWidget {
  const CompletedProjectssWidget({super.key, required this.projectClass});
  final ProjectClass projectClass;
  @override
  State<CompletedProjectssWidget> createState() =>
      _CompletedProjectssWidgetState();
}

class _CompletedProjectssWidgetState extends State<CompletedProjectssWidget> {
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
            width: 200,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              color: Color(0xff455A64),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.projectClass.name,
                    style: TextStyle(
                      color: Colors.lightGreenAccent,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(
                  'Manager : ${widget.projectClass.Email}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
                        color: Colors.lightGreenAccent,
                        backgroundColor: Colors.transparent,
                        value: onGoingCubit
                                .completedPercentage(widget.projectClass) /
                            100,
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
