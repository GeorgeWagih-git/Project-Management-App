import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  List<String> tasks = [
    "User Interviews",
    "Wireframes",
    "Design System",
    "Icons",
    "Final Mockups"
  ];
  List<bool> taskCompletion = [false, false, false, false, false];
  double get progress =>
      taskCompletion.where((task) => task).length / tasks.length;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(child:
      Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                pinned: true,
                expandedHeight: 60.0,
                title: Text(
                  "Task Details",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Real Estate App Design",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.blue),
                          SizedBox(width: 8),
                          Text("Due Date: 20 June",
                              style: TextStyle(color: Colors.black)),
                          Spacer(),
                          Icon(Icons.group, color: Colors.blue),
                          SizedBox(width: 8),
                          Text("Project Team",
                              style: TextStyle(color: Colors.black)),
                          Row(
                            children: List.generate(
                                3,
                                (index) => Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Icon(Icons.account_circle,
                                          color: Colors.blue, size: 20),
                                    )),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Project Details",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unkown printer took a galley of type and scrambled.",
                        style: TextStyle(color: Colors.black87),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Project Progress",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 5.0,
                          percent: progress,
                          center: Text("${(progress * 100).toInt()}%"),
                          progressColor: Colors.blue,
                          backgroundColor: Colors.black26,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "All Tasks",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 218, 218, 218),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tasks[index],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Checkbox(
                              value: taskCompletion[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  taskCompletion[index] = value ?? false;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: tasks.length,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Adding Task..."),
                    ),
                  );
                },
                child: Text("Add Task",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
   
