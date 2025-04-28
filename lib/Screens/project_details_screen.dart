import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/persons_images_list.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/tasks_list_view.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';

import 'package:flutter_application_1/Screens/edit_tasks_screen.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

String globaltaskName = '';

// ignore: must_be_immutable
class ProjectDetailsScreen extends StatelessWidget {
  ProjectDetailsScreen({super.key, required this.projectClass});
  ProjectClass projectClass;

  @override
  Widget build(BuildContext context) {
    var onGoingCubit = OngoingProjectCubit.get(context);
    return CustomScaffold(
      screenName: 'Project Details',
      child: BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
        builder: (context, state) {
          var completedPercentage =
              onGoingCubit.completedPercentage(projectClass);
          return Padding(
            padding: const EdgeInsets.fromLTRB(40, 12, 12, 0),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
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
                                projectClass.name,
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
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
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
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "required";
                                                      }
                                                      return null;
                                                    },
                                                    controller: onGoingCubit
                                                        .projectController,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
                                                      labelText:
                                                          "Project Name ",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                    ),
                                                    autofocus: true,
                                                  ),
                                                  SizedBox(height: 16),
                                                  MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                    color: Color(0xffFED36A),
                                                    onPressed: () {
                                                      // إضافة المهمة هنا
                                                      if (onGoingCubit
                                                          .projectController
                                                          .text
                                                          .isNotEmpty) {
                                                        // setState(() {
                                                        //   widget.projectClass
                                                        //       .renameProject(
                                                        //           .projectController
                                                        //               .text); // ✅ إعادة التسمية
                                                        // });

                                                        onGoingCubit
                                                            .projectController
                                                            .clear();
                                                        Navigator.pop(
                                                            context); // 🟢 مسح الحقل بعد الإضافة
                                                      }

                                                      // إغلاق الواجهة
                                                    },
                                                    child: Text('Rename'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Icon(Icons.edit),
                                ),
                                SizedBox(width: 15),
                                MaterialButton(
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
                                    )),
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
                                  'StartUp Date',
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xff8CAAB9)),
                                ),
                                Text(
                                  "${projectClass.day} ${projectClass.month}/${projectClass.year}",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                Text(
                                  'Dead Date',
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xff8CAAB9)),
                                ),
                                Text(
                                  "${projectClass.deadday} ${projectClass.deadmonth}/${projectClass.deadyear}",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration:
                                  BoxDecoration(color: Color(0xffFED36A)),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "required";
                                                  }
                                                  return null;
                                                },
                                                controller:
                                                    onGoingCubit.description,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  labelStyle: TextStyle(
                                                      color: Colors.white),
                                                  labelText: "New Dicription ",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                ),
                                                autofocus: true,
                                                maxLines: null,
                                                keyboardType:
                                                    TextInputType.multiline,
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              MaterialButton(
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
                                                            child:
                                                                Text('Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {},
                                                            child: Text('Edit'),
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text('Edit'),
                                              ),
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
                          projectClass.projectDetails,
                          style:
                              TextStyle(color: Color(0xffBCCFD8), fontSize: 12),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Project Progrss',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: CircularPercentIndicator(
                                progressColor: Color(0xffFED36A),
                                radius: 50,
                                percent: (completedPercentage / 100).toDouble(),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                    minWidth: 20,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
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
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "required";
                                                      }
                                                      return null;
                                                    },
                                                    controller: onGoingCubit
                                                        .taskController,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
                                                      labelText: "Task Name ",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                    ),
                                                    autofocus: true,
                                                  ),
                                                  MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                    color: Color(0xffFED36A),
                                                    onPressed: () {
                                                      if (onGoingCubit
                                                          .taskController
                                                          .text
                                                          .isNotEmpty) {
                                                        onGoingCubit
                                                            .addTaskIntoProject(
                                                                projectRelatedToTask:
                                                                    projectClass);
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Text('Add'),
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
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  color: Color(0xffFED36A),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EditTasksScreen(
                                            projectClass: projectClass,
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
                ),
                TaskListview(
                  project: projectClass,
                  showcheckbox: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
