import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/ongoing_projects_list.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/signin_screen.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/add_projrct_button.dart';
import 'package:flutter_application_1/widgets/completed_projects_widget.dart';
import 'package:flutter_application_1/widgets/inline_search_bar.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  bool isReturning = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    setState(() {
      isReturning = false;
    });
    OngoingProjectCubit.get(context).fetchAllProjects();
  }

  UserModel? user;
  @override
  void initState() {
    super.initState();
    loadUserData();
    OngoingProjectCubit.get(context).fetchAllProjects();
  }

  void loadUserData() async {
    final loadedUser = await AppPrefs.getUser();
    setState(() {
      user = loadedUser;
    });
  }

  String projectname = 'No Name';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OngoingProjectCubit, OngoingProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return CustomScaffold(
            homeSelected: true,
            chatSelected: isReturning,
            calenderSelected: isReturning,
            notificationSelected: isReturning,
            showhomebottombar: true,
            showappbar: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await OngoingProjectCubit.get(context).fetchAllProjects();
                },
                child: CustomScrollView(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Welcome Back!',
                                          style: TextStyle(
                                              color: Color(0xffFED36A)),
                                        ),
                                        Text(
                                          user?.fullName ?? 'Loading...',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    user?.imageUrl != null
                                        ? CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                NetworkImage(user!.imageUrl!),
                                          )
                                        : CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                AssetImage('assets/person.png'),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 300, child: InlineSearchBar()),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffFED36A),
                                    ),
                                    child: IconButton(
                                      onPressed: () async {
                                        bool confirm = await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text(
                                                'logout confirmation'),
                                            content: const Text(
                                                'are you sure ypu want to logout ?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, false),
                                                child: const Text('cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, true),
                                                child: const Text('log out'),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          await AppPrefs.logout();

                                          if (mounted) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const SigninScreen()),
                                              (route) => false,
                                            );
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.logout),
                                    ))
                              ],
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Completed Projects',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 12),
                              child: SizedBox(
                                width: double.infinity,
                                height: 170,
                                child: BlocBuilder<OngoingProjectCubit,
                                    OngoingProjectStates>(
                                  builder: (context, state) {
                                    var completedprojects =
                                        OngoingProjectCubit.get(context)
                                            .completedprojects;
                                    if (completedprojects.isNotEmpty) {
                                      return ListView.builder(
                                        itemCount: completedprojects.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return CompletedProjectssWidget(
                                            projectClass:
                                                completedprojects[index],
                                          );
                                        },
                                      );
                                    } else {
                                      return Center(
                                        child: Text(
                                          'No Completed Projects Yet !',
                                          style: TextStyle(
                                              color: Color(0xffFED36A),
                                              fontSize: 25),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ongoing Projects',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                  AddProjectButton(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      OngoingTasksList(),
                    ]),
              ),
            ),
          );
        });
  }
}
