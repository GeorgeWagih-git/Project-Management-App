import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/ongoing_projects_list.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/add_projrct_button.dart';
import 'package:flutter_application_1/widgets/completed_projects_widget.dart';
import 'package:flutter_application_1/widgets/inline_search_bar.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:provider/provider.dart';

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
    // يتم استدعاء هذه الدالة عند الرجوع إلى الصفحة الرئيسية
    setState(() {
      isReturning = false; // تحديث المتغير وإعادة بناء الواجهة
    });
  }

  String projectname = 'No Name';
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      homeSelected: true,
      chatSelected: isReturning,
      calenderSelected: isReturning,
      notificationSelected: isReturning,
      showhomebottombar: true,
      showappbar: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
        child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
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
                            Text(
                              'Welcome Back!',
                              style: TextStyle(color: Color(0xffFED36A)),
                            ),
                            Text(
                              'George Wagih',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                        Image.asset('assets/person.png')
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
                        onPressed: () {},
                        icon: Icon(Icons.settings),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Completed Projects',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See all',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xffFED36A)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 175,
                    child: Consumer<ProjectClass>(
                      builder: (context, value, child) {
                        if (value.completedlist.isEmpty) {
                          return Center(
                            child: Text(
                              'No Completed Projects Yet !',
                              style: TextStyle(
                                  color: Color(0xffFED36A), fontSize: 25),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CompletedTasksWidget(
                                  projectClass: value.completedlist[
                                      index]); // ✅ تحويل `ProjectClass` إلى Widget
                            },
                            itemCount: value.completedlist.length,
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text(
                        'See all',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xffFED36A)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          OngoingTasksList(),
        ]),
      ),
    );
  }
}
