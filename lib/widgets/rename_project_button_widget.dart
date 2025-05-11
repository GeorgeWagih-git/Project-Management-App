import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';

class RenameProjectButtonWidget extends StatelessWidget {
  const RenameProjectButtonWidget({
    super.key,
    required this.onGoingCubit,
    required this.widget,
  });

  final OngoingProjectCubit onGoingCubit;
  final ProjectDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color(0xffFED36A),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Color(0xff212832),
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: 300,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Rename Project',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pop(context); // إغلاق القائمة
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        controller: onGoingCubit.projectController,
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
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Color(0xffFED36A),
                        onPressed: () {
                          // إضافة المهمة هنا
                          if (onGoingCubit.projectController.text.isNotEmpty) {
                            onGoingCubit.renameProject(
                                model: widget.projectClass,
                                newname: onGoingCubit.projectController.text);

                            Navigator.pop(context);
                          }
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
    );
  }
}
