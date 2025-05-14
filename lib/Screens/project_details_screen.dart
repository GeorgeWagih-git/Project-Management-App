import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/tasks_list_view.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/widgets/add_task_button.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/delete_project_button_widget.dart';
import 'package:flutter_application_1/widgets/rename_project_button_widget.dart';
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
    return CustomScaffold(
      screenName: 'Project Details',
      child: BlocConsumer<OngoingProjectCubit, OngoingProjectStates>(
        listener: (context, state) {
          if (state is SingleProjectFetchedSuccessfully) {
            setState(() {
              _project = state.project;
            });
          }
        },
        builder: (context, state) {
          String deadDate =
              DateFormat('dd MMM yyyy - h:mm a').format(_project.deadline);
          String createdDate =
              DateFormat('dd MMM yyyy - h:mm a').format(_project.createdDate);
          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final onGoingCubit = OngoingProjectCubit.get(context);

          final project = state is SingleProjectFetchedSuccessfully
              ? state.project
              : widget.projectClass;

          final completedPercentage =
              onGoingCubit.completedPercentage(_project);

          return Padding(
            padding: const EdgeInsets.fromLTRB(40, 12, 12, 0),
            child: RefreshIndicator(
              onRefresh: () async {
                await OngoingProjectCubit.get(context)
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _project.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Manager :  ${_project.managerUserName}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              user?.userName == project.managerUserName
                                  ? RenameProjectButtonWidget(
                                      onGoingCubit: onGoingCubit,
                                      widget: widget)
                                  : const SizedBox(),
                              SizedBox(width: 15),
                              user?.userName == project.managerUserName
                                  ? DeleteProjectButtonWidget(
                                      onGoingCubit: onGoingCubit,
                                      widget: widget)
                                  : SizedBox(width: 15),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration:
                                    BoxDecoration(color: Color(0xffFED36A)),
                                child: Icon(Icons.start_sharp),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'created Date',
                                    style: TextStyle(
                                        fontSize: 11, color: Color(0xff8CAAB9)),
                                  ),
                                  Text(
                                    createdDate,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration:
                                    BoxDecoration(color: Color(0xffFED36A)),
                                child: Icon(Icons.calendar_month),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dead Date',
                                    style: TextStyle(
                                        fontSize: 11, color: Color(0xff8CAAB9)),
                                  ),
                                  Text(
                                    deadDate,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Project Details',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            _project.projectDetails,
                            style: TextStyle(
                                color: Color(0xffBCCFD8), fontSize: 12),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Project Progrss',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: CircularPercentIndicator(
                                  progressColor: Color(0xffFED36A),
                                  radius: 50,
                                  percent:
                                      (completedPercentage / 100).toDouble(),
                                  center: Text(
                                    "${completedPercentage.toString()}%",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'All Tasks',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  user?.userName == project.managerUserName
                                      ? AddTaskButton(
                                          onGoingCubit: onGoingCubit,
                                          projectId: project.id,
                                        )
                                      : const SizedBox(),
                                  SizedBox(width: 15),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
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
}
