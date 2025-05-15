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
        final filtered = OngoingProjectCubit.get(context).filteredProjects;

        if (state is ProjectsSuccessfulState && filtered.isNotEmpty) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return OngoingProjectsWidget(
                  projectClass: filtered[index],
                );
              },
              childCount: filtered.length,
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
              child: Center(
                child: Text(
                  'No Ongoing Projects Yet!',
                  style: TextStyle(color: Color(0xffFED36A), fontSize: 25),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
