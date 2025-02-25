import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/tasks_list.dart';
import 'package:flutter_application_1/Classes/tasks_list_view.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});
  //double completedPercentag = 0;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenName: 'Project Details',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 12, 12, 0),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Real Estate App Design',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 47,
                        height: 47,
                        decoration: BoxDecoration(color: Color(0xffFED36A)),
                        child: Icon(Icons.calendar_month),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 11, color: Color(0xff8CAAB9)),
                          ),
                          Text(
                            '20 June',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        width: 47,
                        height: 47,
                        decoration: BoxDecoration(color: Color(0xffFED36A)),
                        child: Icon(Icons.people),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Project Team',
                            style: TextStyle(
                                fontSize: 11, color: Color(0xff8CAAB9)),
                          ),
                          SizedBox(
                              height: 20,
                              width: 81,
                              child: ListView.builder(
                                //shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    personImages[index],
                                    fit: BoxFit.fill,
                                  );
                                },
                                itemCount: personImages.length,
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Project Details',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled",
                    style: TextStyle(color: Color(0xffBCCFD8), fontSize: 12),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Project Progrss',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: CircularPercentIndicator(
                            progressColor: Color(0xffFED36A),
                            radius: 30,
                            percent: completedPercentage(),
                            center: Text(
                              "${(completedPercentage() * 100).toInt()}%",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'All Tasks',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            TaskListView(),
          ],
        ),
      ),
    );
  }
}
