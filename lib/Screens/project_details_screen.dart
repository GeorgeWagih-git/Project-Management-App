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
  final TextEditingController _projectController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _description = TextEditingController();
  void updateTaskStatus() {
    setState(() {
      Provider.of<ProjectClass>(context, listen: false)
          .toggleProjectStatus(widget.projectClass);
    });
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.projectClass.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            overflow: TextOverflow.ellipsis,
                          ), // إضافة نقاط (...) إذا تجاوز النص المساحة
                          maxLines: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            minWidth: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: Color(0xffFED36A),
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  backgroundColor: Color(0xff212832),
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: Container(
                                        height: 300,
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                'Rename Project',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onTap: () {
                                                Navigator.pop(
                                                    context); // إغلاق القائمة
                                              },
                                            ),
                                            TextField(
                                              controller: _projectController,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                labelText: "Project Name ",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                              ),
                                              autofocus: true,
                                            ),
                                            SizedBox(height: 16),
                                            Consumer<ProjectClass>(
                                              builder: (context, model, child) {
                                                return MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  color: Color(0xffFED36A),
                                                  onPressed: () {
                                                    // إضافة المهمة هنا
                                                    if (_projectController
                                                        .text.isNotEmpty) {
                                                      setState(() {
                                                        widget.projectClass
                                                            .renameProject(
                                                                _projectController
                                                                    .text); // ✅ إعادة التسمية
                                                      });

                                                      _projectController
                                                          .clear();
                                                      Navigator.pop(
                                                          context); // 🟢 مسح الحقل بعد الإضافة
                                                    }

                                                    // إغلاق الواجهة
                                                  },
                                                  child: Text('Rename'),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Icon(Icons.edit),
                          ),
                          SizedBox(width: 15),
                          Consumer<ProjectClass>(
                            builder: (context, model, child) {
                              return MaterialButton(
                                  minWidth: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  color: Color(0xffFED36A),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Delete Project'),
                                          content: Text(
                                              'Are you sure you want to delete this project?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  model.deleteProject(
                                                      widget.projectClass);
                                                  _projectController.clear();
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Delete'))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete,
                                  ));
                            },
                          ),
                        ],
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
                            'StartUp Date',
                            style: TextStyle(
                                fontSize: 11, color: Color(0xff8CAAB9)),
                          ),
                          Text(
                            "${widget.projectClass.day} ${widget.projectClass.month}/${widget.projectClass.year}",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          Text(
                            'Dead Date',
                            style: TextStyle(
                                fontSize: 11, color: Color(0xff8CAAB9)),
                          ),
                          Text(
                            "${widget.projectClass.deadday} ${widget.projectClass.deadmonth}/${widget.projectClass.deadyear}",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Project Details',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      MaterialButton(
                        minWidth: 20,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Color(0xffFED36A),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Color(0xff212832),
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    margin: EdgeInsets.all(20),
                                    height: 400,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Edit Project Discription',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextField(
                                          controller: _description,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            labelText: "New Dicription ",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                          ),
                                          autofocus: true,
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Consumer<ProjectClass>(
                                          builder: (context, value, child) {
                                            return MaterialButton(
                                              minWidth: 20,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              color: Color(0xffFED36A),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Edit Project Description'),
                                                      content: Text(
                                                          'Are you sure you want to Edit this project Description?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              if (_description
                                                                  .text
                                                                  .isNotEmpty) {
                                                                setState(() {
                                                                  widget
                                                                      .projectClass
                                                                      .editDetails(
                                                                          _description
                                                                              .text);
                                                                  _description
                                                                      .clear();
                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              }
                                                            },
                                                            child: Text('Edit'))
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text('Edit'),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Icon(Icons.edit_note),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.projectClass.projectDetails,
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
                        child: Consumer<ProjectClass>(
                          builder: (context, projectClass, child) {
                            return CircularPercentIndicator(
                              progressColor: Color(0xffFED36A),
                              radius: 50,
                              percent:
                                  widget.projectClass.completedPercentage(),
                              center: Text(
                                "${(widget.projectClass.completedPercentage() * 100).toStringAsFixed(0)}%",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            );
                          },
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
                                  isScrollControlled: true,
                                  backgroundColor: Color(0xff212832),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
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
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                            Consumer<TaskModel>(
                                              builder: (context, model, child) {
                                                return MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  color: Color(0xffFED36A),
                                                  onPressed: () {
                                                    if (_taskController
                                                        .text.isNotEmpty) {
                                                      setState(() {
                                                        widget
                                                            .projectClass.tasks
                                                            .add(TaskModel(
                                                                name: _taskController
                                                                    .text)); // ✅ إضافة المهمة للمشروع مباشرة
                                                      });

                                                      _taskController
                                                          .clear(); // مسح النص بعد الإضافة
                                                      Navigator.pop(
                                                          context); // إغلاق النافذة
                                                    }
                                                  },
                                                  child: Text('Add'),
                                                );
                                              },
                                            ),

                                            // مسافة بين الحقل والزر
                                            SizedBox(height: 16),
                                          ],
                                        ),
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
                                    return EditTasksScreen(
                                      projectClass: widget.projectClass,
                                    );
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
            /*Consumer<ProjectClass>(
              builder: (context, value, child) {
                return TaskListView(
                  project: widget.projectClass,
                  tasks: widget
                      .projectClass.tasks, // ✅ الآن يتم تمرير `List<TaskItem>`
                  showcheckbox: true,
                );
              },
            ),*/
            TaskListView(
              project: widget.projectClass,
              tasks: widget
                  .projectClass.tasks, // ✅ الآن يتم تمرير `List<TaskItem>`
              showcheckbox: true,
            ),
          ],
        ),
      ),
    );
  }
}
