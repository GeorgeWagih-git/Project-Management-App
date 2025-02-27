import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Classes/tasks_list_view.dart';
import 'package:flutter_application_1/Screens/edit_tasks_screen.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

String globaltaskName = '';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key, required this.projectClass});
  final ProjectClass projectClass;
  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  final TextEditingController _taskController = TextEditingController();
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
                    widget.projectClass.name!,
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
                            "${widget.projectClass.day}${widget.projectClass.month}",
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
                        child: Consumer<TaskModel>(
                          builder: (context, model, child) {
                            return CircularPercentIndicator(
                                progressColor: Color(0xffFED36A),
                                radius: 50,
                                percent:
                                    model.completedPercentagewithprovider(),
                                center: Text(
                                  "${(model.completedPercentagewithprovider() * 100)}%",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ));
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Tasks',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                              minWidth: 20,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              color: Color(0xffFED36A),
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor: Color(0xff212832),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                              "Add New Task",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              Navigator.pop(
                                                  context); // إغلاق القائمة
                                            },
                                          ),
                                          TextField(
                                            controller: _taskController,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              labelText: "Task Name ",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                            ),
                                            autofocus: true,
                                          ),
                                          SizedBox(
                                              height:
                                                  16), // مسافة بين الحقل والزر
                                          Consumer<TaskModel>(
                                              builder: (context, model, child) {
                                            return MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              color: Color(0xffFED36A),
                                              onPressed: () {
                                                // إضافة المهمة هنا
                                                if (_taskController
                                                    .text.isNotEmpty) {
                                                  model.add(TaskItem(
                                                      name: _taskController
                                                          .text));
                                                  _taskController.clear();
                                                  Navigator.pop(
                                                      context); // 🟢 مسح الحقل بعد الإضافة
                                                }

                                                // إغلاق الواجهة
                                              },
                                              child: Text('Add'),
                                            );
                                          }),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.add,
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          MaterialButton(
                            minWidth: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: Color(0xffFED36A),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EditTasksScreen();
                                  },
                                ),
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            TaskListView(
              showcheckbox: true,
            ),
          ],
        ),
      ),
    );
  }
}
