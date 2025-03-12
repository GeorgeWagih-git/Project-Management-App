import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:provider/provider.dart';

class AddProjectButton extends StatelessWidget {
  AddProjectButton({super.key});

  final TextEditingController _projectControllername = TextEditingController();
  final TextEditingController _projectControllerday = TextEditingController();
  final TextEditingController _projectControllermonth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color(0xffFED36A),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Color(0xff212832),
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Add New Project",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextField(
                        controller: _projectControllername,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Project Name ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        autofocus: true,
                      ),
                      SizedBox(height: 16),
                      ListTile(
                        title: Text(
                          "Dead Line",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _projectControllerday,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: "Day ",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                              autofocus: true,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: _projectControllermonth,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: "Month ",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                              autofocus: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16), // مسافة بين الحقل والزر
                      Consumer<ProjectClass>(
                        builder: (context, value, child) {
                          return MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: Color(0xffFED36A),
                            onPressed: () {
                              String inputday = _projectControllerday.text;
                              int numberday = 1;
                              if (inputday.isNotEmpty) {
                                numberday = int.parse(inputday);
                              }
                              if (_projectControllername.text.isNotEmpty) {
                                ProjectClass newProject = ProjectClass(
                                  name: _projectControllername.text,
                                  day: numberday,
                                  month: _projectControllermonth.text,
                                );

                                /*OngoingProjectsWidget newOngoingProject =
                                    OngoingProjectsWidget(
                                  projectClass: newProject,
                                );*/

                                // إضافة المشروع الجديد إلى القائمة
                                value.addProject(
                                    newProject); // ✅ إضافة المشروع ككائن `ProjectClass` فقط

                                // إغلاق الواجهة
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Add'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Icon(Icons.add, color: Colors.black),
    );
  }
}
