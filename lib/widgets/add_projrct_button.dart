import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({super.key});
  @override
  Widget build(BuildContext context) {
    var ongoingCubit = OngoingProjectCubit.get(context);
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
                  child: Form(
                    key: ongoingCubit.ongoingFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "Add New Project",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "required";
                            }
                            return null;
                          },
                          controller: ongoingCubit.projectControllername,
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
                        StartUpDate(),

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
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller:
                                    ongoingCubit.projectControllerdayDead,
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
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                                controller:
                                    ongoingCubit.projectControllermonthDead,
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
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller:
                                    ongoingCubit.projectControlleryearDead,
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
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                            controller:
                                ongoingCubit.projectControllerDiscription,
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
                        BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
                          builder: (context, state) {
                            return MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              color: Color(0xffFED36A),
                              onPressed: () {
                                if (ongoingCubit.ongoingFormKey.currentState!
                                    .validate()) {
                                  ongoingCubit.addProjects();
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
              ),
            );
          },
        );
      },
      child: Icon(Icons.add, color: Colors.black),
    );
  }
}

class StartUpDate extends StatelessWidget {
  const StartUpDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var ongoingCubit = OngoingProjectCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // TimePickerDialog(initialTime: TimeOfDay.now())
        SizedBox(
          width: 100,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "required";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: ongoingCubit.projectControllerday,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: "Day ",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            ),
            autofocus: true,
          ),
        ),
        SizedBox(
          width: 100,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "required";
              }
              return null;
            },
            controller: ongoingCubit.projectControllermonth,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: "Month ",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            ),
            autofocus: true,
          ),
        ),
        SizedBox(
          width: 100,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "required";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: ongoingCubit.projectControlleryear,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: "Year ",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            ),
            autofocus: true,
          ),
        ),
      ],
    );
  }
}
