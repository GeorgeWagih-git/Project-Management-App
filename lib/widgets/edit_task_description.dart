import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';

class EditTaskDescriptionButton extends StatelessWidget {
  const EditTaskDescriptionButton({
    super.key,
    required this.onGoingCubit,
    required this.taskitem,
  });

  final OngoingProjectCubit onGoingCubit;
  final TaskModel taskitem;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color(0xffFED36A),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Color(0xff212832),
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 400,
                  child: Column(
                    children: [
                      Text(
                        'Edit Discription',
                        style: TextStyle(color: Colors.white),
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
                        controller: onGoingCubit.tasKdescription,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "New Dicription ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        autofocus: true,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      MaterialButton(
                        minWidth: 20,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Color(0xffFED36A),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Edit Description'),
                                content: Text(
                                    'Are you sure you want to Edit this Description?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (onGoingCubit
                                          .tasKdescription.text.isNotEmpty) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      }
                                    },
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
    );
  }
}
