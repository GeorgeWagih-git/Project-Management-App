import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
//import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Classes/tasks_list_view.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
//import 'package:flutter_application_1/Screens/task_details_screen.dart';
//import 'package:flutter_application_1/core/functions/navigate_to.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/widgets/add_task_button.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/delete_project_button_widget.dart';
import 'package:flutter_application_1/widgets/edit_project_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

String globaltaskName = '';

// ignore: must_be_immutable
class ProjectDetailsScreen extends StatefulWidget {
  ProjectDetailsScreen({super.key, required this.projectClass});
  ProjectClass projectClass;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  late ProjectClass _project;

  UserModel? user;

  @override
  void initState() {
    super.initState();
    _project = widget.projectClass;
    fetchProject();
    loadUser(); //
  }

  Future<void> loadUser() async {
    user = await AppPrefs.getUser();
    setState(() {});
  }

  Future<void> fetchProject() async {
    final cubit = OngoingProjectCubit.get(context);
    await cubit.fetchProjectWithTasks(_project.id);

    final state = cubit.state;
    if (state is SingleProjectFetchedSuccessfully) {
      setState(() {
        _project = state.project;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 380;

    return CustomScaffoldWidget(
      screenName: 'Project Details',
      child: BlocConsumer<OngoingProjectCubit, OngoingProjectStates>(
        listener: (context, state) {
          if (state is SingleProjectFetchedSuccessfully) {
            setState(() {
              _project = state.project;
            });
          } else if (state is ProjectCreateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Task added successfully')),
            );
          } else if (state is ProjectCreateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to add task: ${state.errMessage}')),
            );
          }
        },
        builder: (context, state) {
          final onGoingCubit = OngoingProjectCubit.get(context);
          final project = state is SingleProjectFetchedSuccessfully
              ? state.project
              : widget.projectClass;

          final completedPercentage =
              onGoingCubit.completedPercentage(_project);
          final String deadDate =
              DateFormat('dd MMM yyyy - h:mm a').format(_project.deadline);
          final String createdDate =
              DateFormat('dd MMM yyyy - h:mm a').format(_project.createdDate);

          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: RefreshIndicator(
              onRefresh: () async {
                await onGoingCubit
                    .fetchProjectWithTasks(widget.projectClass.id);
              },
              child: CustomScrollView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Form(
                      key: onGoingCubit.projectDetailsScreenFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title
                          Text(
                            _project.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 20 : 25,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Manager: ${_project.managerUserName}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isSmallScreen ? 16 : 20,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.messenger,
                                  color: Colors.white,
                                ),
                                highlightColor: Colors.amber,
                              ),
                            ],
                          ),

                          if (user?.userName == project.managerUserName)
                            Row(
                              children: [
                                EditProjectButtonWidget(
                                    onGoingCubit: onGoingCubit, widget: widget),
                                const SizedBox(width: 15),
                                DeleteProjectButtonWidget(
                                    onGoingCubit: onGoingCubit, widget: widget),
                              ],
                            ),
                          const SizedBox(height: 30),

                          _buildIconTextRow(
                            icon: Icons.access_time,
                            title: 'Created Date',
                            value: createdDate,
                          ),
                          const SizedBox(height: 20),

                          _buildIconTextRow(
                            icon: Icons.calendar_month,
                            title: 'Dead Date',
                            value: deadDate,
                          ),
                          const SizedBox(height: 30),

                          _buildSectionTitle('Project Details'),
                          const SizedBox(height: 10),
                          Text(
                            _project.projectDetails,
                            style: const TextStyle(
                                color: Color(0xffBCCFD8), fontSize: 13),
                          ),
                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSectionTitle('Project Progress'),
                              CircularPercentIndicator(
                                radius: 50,
                                percent: (completedPercentage / 100).toDouble(),
                                progressColor: const Color(0xffFED36A),
                                center: Text(
                                  "$completedPercentage%",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSectionTitle('All Tasks'),
                              if (user?.userName == project.managerUserName)
                                state is ProjectCreateLoading
                                    ? const Padding(
                                        padding: EdgeInsets.only(right: 16),
                                        child: CircularProgressIndicator(
                                            color: Colors.amber),
                                      )
                                    : AddTaskButton(
                                        onGoingCubit: onGoingCubit,
                                        projectId: project.id,
                                      ),
                              /*MaterialButton(
                                  minWidth: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  color: Colors.blue,
                                  child: Icon(Icons.text_snippet_outlined),
                                  onPressed: () {
                                    navigateTo(
                                        context,
                                        TaskDetailsScreen(
                                            taskitem: TaskModel(
                                                id: 1,
                                                title: 'offline test',
                                                description: 'offline test',
                                                deadline: date,
                                                assignedTo: 'offline test',
                                                isDone: true,
                                                projectId: 1,
                                                createdDate: date),
                                            onGoingCubit: onGoingCubit,
                                            user: user!,
                                            projectClass: widget.projectClass));
                                  }),*/
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  TaskListview(
                    project: _project,
                    user: user!,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconTextRow(
      {required IconData icon, required String title, required String value}) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(color: Color(0xffFED36A)),
          child: Icon(icon),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 11, color: Color(0xff8CAAB9))),
            Text(value,
                style: const TextStyle(fontSize: 17, color: Colors.white)),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 18),
    );
  }
}

final int day = 11;
final int month = 10;
final int year = 2025;
int hour = 4;
final int minute = 55;
final DateTime date = DateTime(
  year,
  month,
  day,
  hour,
  minute,
);
