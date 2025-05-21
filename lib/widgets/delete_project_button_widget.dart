import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteProjectButtonWidget extends StatelessWidget {
  const DeleteProjectButtonWidget({
    super.key,
    required this.onGoingCubit,
    required this.widget,
  });

  final OngoingProjectCubit onGoingCubit;
  final ProjectDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: 20,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Color(0xffFED36A),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Delete Project'),
                content: Text('Are you sure you want to delete this project?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await onGoingCubit
                          .deleteProjectFromServer(widget.projectClass.id);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                                  value: onGoingCubit..fetchAllProjects(),
                                  child: const HomeScreen(),
                                )),
                        (route) => false,
                      );
                    },
                    child: Text('Delete'),
                  )
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.delete,
        ));
  }
}
