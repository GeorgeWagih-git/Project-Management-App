import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/ongoing_projects_list.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/profile_screen.dart';
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
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = screenWidth < 380;

        return CustomScaffoldWidget(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Welcome Back!',
                                      style:
                                          TextStyle(color: Color(0xffFED36A)),
                                    ),
                                    Text(
                                      user?.fullName ?? 'Loading...',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileScreen()),
                                    );
                                  },
                                  child: user?.imageUrl != null
                                      ? FutureBuilder(
                                          future: AppPrefs
                                              .getProfileImageTimestamp(),
                                          builder: (context, snapshot) {
                                            String imageUrl = user!.imageUrl!;
                                            if (snapshot.hasData) {
                                              imageUrl += "?v=${snapshot.data}";
                                            }
                                            return CircleAvatar(
                                              radius: 30,
                                              backgroundImage:
                                                  NetworkImage(imageUrl),
                                            );
                                          })
                                      : const CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              AssetImage('assets/person.png'),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InlineSearchBar(),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () async {
                                      final confirm = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title:
                                              const Text('Logout Confirmation'),
                                          content: const Text(
                                              'Are you sure you want to logout?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: const Text('Logout'),
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
                                    icon: const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Completed Projects',
                            style: TextStyle(
                                fontSize: isSmallScreen ? 18 : 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                                var filteredCompleted =
                                    OngoingProjectCubit.get(context)
                                        .filteredCompletedProjects;

                                if (filteredCompleted.isNotEmpty) {
                                  return ListView.builder(
                                    itemCount: filteredCompleted.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CompletedProjectssWidget(
                                        projectClass: filteredCompleted[index],
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: Text(
                                      'No Completed Projects Yet!',
                                      style: TextStyle(
                                          color: Color(0xffFED36A),
                                          fontSize: 20),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ongoing Projects',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 18 : 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              AddProjectButton(),
                              /*  MaterialButton(
                                  minWidth: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  color: Colors.blue,
                                  child: Icon(Icons.text_snippet_outlined),
                                  onPressed: () {
                                    navigateTo(
                                        context,
                                        ProjectDetailsScreen(
                                            projectClass: ProjectClass(
                                                id: 1,
                                                tasks: [],
                                                deadline: date,
                                                name: 'offline test',
                                                projectDetails: 'offline test',
                                                managerUserName: 'offline test',
                                                createdDate: date)));
                                  })*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  OngoingTasksList(),
                ],
              ),
            ),
          ),
        );
      },
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
