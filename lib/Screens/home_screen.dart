import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/Ongoing_tasks_list.dart';
import 'package:flutter_application_1/Classes/tasks_list.dart';
import 'package:flutter_application_1/widgets/inline_search_bar.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showappbar: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
        child: SingleChildScrollView(
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
                SizedBox(width: 370, child: InlineSearchBar()),
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
                    'Completed Tasks',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(fontSize: 18, color: Color(0xffFED36A)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: SizedBox(
                width: double.infinity,
                height: 175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return completedlist[index];
                  },
                  itemCount: completedlist.length,
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
                    'Ongoing Tasks',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(fontSize: 18, color: Color(0xffFED36A)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              width: 405,
              child: CustomScrollView(
                slivers: [
                  OngoingTasksList(),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
