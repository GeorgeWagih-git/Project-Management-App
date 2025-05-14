import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/widgets/ongoing_projects_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngoingTasksList extends StatelessWidget {
  const OngoingTasksList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
        builder: (context, state) {
      if (state is ProjectsSuccessfulState) {
        var projectList = state.project;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: projectList.length,
            (context, index) {
              return OngoingProjectsWidget(projectClass: projectList[index]);
            },
          ),
        );
      } else {
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 150,
            child: Center(
              child: Text(
                'No Ongoing Projects Yet !',
                style: TextStyle(color: Color(0xffFED36A), fontSize: 25),
              ),
            ),
          ),
        );
      }
    });
  }
}
