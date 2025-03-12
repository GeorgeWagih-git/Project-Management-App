import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:provider/provider.dart';

class AddProjectButton extends StatelessWidget {
  AddProjectButton({super.key});

  final TextEditingController _projectControllername = TextEditingController();
  final TextEditingController _projectControllerday = TextEditingController();
  final TextEditingController _projectControllermonth = TextEditingController();
  final TextEditingController _projectControlleryear = TextEditingController();
  final TextEditingController _projectControllerDiscription =
      TextEditingController();
  final TextEditingController _projectControllerdayDead =
      TextEditingController();
  final TextEditingController _projectControllermonthDead =
      TextEditingController();
  final TextEditingController _projectControlleryearDead =
      TextEditingController();

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
                          "Startup Time",
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
                            width: 100,
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
                          SizedBox(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _projectControlleryear,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: "Year ",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                              autofocus: true,
                            ),
                          ),
                        ],
                      ),

                      ListTile(
                        title: Text(
                          "DeadLine Time",
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
                              controller: _projectControllerdayDead,
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
                            width: 100,
                            child: TextField(
                              controller: _projectControllermonthDead,
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
                          SizedBox(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _projectControlleryearDead,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: "Year ",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                              autofocus: true,
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(
                          "Project Details",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _projectControllerDiscription,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: "Disctiption ",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          autofocus: true,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                        ),
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
                              String inputyear = _projectControlleryear.text;
                              int numberyear = 1;
                              if (inputyear.isNotEmpty) {
                                numberyear = int.parse(inputyear);
                              }
                              ////////////////////////////////////////////////
                              String inputdeadday =
                                  _projectControllerdayDead.text;
                              int numberdeadday = 1;
                              if (inputdeadday.isNotEmpty) {
                                numberdeadday = int.parse(inputdeadday);
                              }
                              String inputdeadyear =
                                  _projectControlleryearDead.text;
                              int numberdeadyear = 1;
                              if (inputdeadyear.isNotEmpty) {
                                numberdeadyear = int.parse(inputdeadyear);
                              }
                              /////////////////////////////////////////////////////
                              if (_projectControllername.text.isNotEmpty) {
                                ProjectClass newProject = ProjectClass(
                                  name: _projectControllername.text,
                                  day: numberday,
                                  month: _projectControllermonth.text,
                                  year: numberyear,
                                  deadday: numberdeadday,
                                  deadmonth: _projectControllermonthDead.text,
                                  deadyear: numberdeadyear,
                                  projectDetails:
                                      _projectControllerDiscription.text,
                                );

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
