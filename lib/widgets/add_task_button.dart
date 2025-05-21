import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
    required this.onGoingCubit,
    required this.projectId,
  });

  final OngoingProjectCubit onGoingCubit;
  final int projectId;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: 20,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(
                          "Add New Task",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        controller: onGoingCubit.tasKTitle,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Task Name ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        autofocus: true,
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
                              controller: onGoingCubit.tasKDay,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Day',
                                labelStyle: TextStyle(color: Colors.amber),
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
                              controller: onGoingCubit.tasKMonth,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Month',
                                labelStyle: TextStyle(color: Colors.amber),
                              ),
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
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
                              controller: onGoingCubit.tasKYear,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Year',
                                labelStyle: TextStyle(color: Colors.amber),
                              ),
                              autofocus: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 80,
                            child: TextFormField(
                              controller: onGoingCubit.taskHourController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Hour',
                                labelStyle: TextStyle(color: Colors.amber),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 80,
                            child: TextFormField(
                              controller: onGoingCubit.taskMinuteController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Minute',
                                labelStyle: TextStyle(color: Colors.amber),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          DropdownButton<String>(
                            value: onGoingCubit.taskPeriod,
                            dropdownColor: Color(0xff212832),
                            items: ['AM', 'PM'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              onGoingCubit.taskPeriod = newValue!;
                              (context as Element).markNeedsBuild();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 300,
                          minHeight: 100,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "required";
                            }
                            return null;
                          },
                          controller: onGoingCubit.tasKdescription,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.amber),
                            labelText: "Disciption ",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          autofocus: true,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required";
                                }
                                return null;
                              },
                              controller: onGoingCubit.tasKAssignedTo,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Assigned To (Email)',
                                labelStyle: TextStyle(color: Colors.amber),
                              ),
                              autofocus: true,
                            ),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: Color(0xffFED36A),
                            onPressed: () {
                              if (onGoingCubit.tasKTitle.text.isNotEmpty &&
                                  onGoingCubit.tasKDay.text.isNotEmpty &&
                                  onGoingCubit.tasKMonth.text.isNotEmpty &&
                                  onGoingCubit.tasKYear.text.isNotEmpty &&
                                  onGoingCubit
                                      .tasKdescription.text.isNotEmpty &&
                                  onGoingCubit.tasKAssignedTo.text.isNotEmpty) {
                                final int day =
                                    int.parse(onGoingCubit.tasKDay.text);
                                final int month =
                                    int.parse(onGoingCubit.tasKMonth.text);
                                final int year =
                                    int.parse(onGoingCubit.tasKYear.text);

                                int hour = int.tryParse(
                                        onGoingCubit.taskHourController.text) ??
                                    0;
                                int minute = int.tryParse(onGoingCubit
                                        .taskMinuteController.text) ??
                                    0;
                                String period = onGoingCubit.taskPeriod;

                                if (period == 'PM' && hour < 12) hour += 12;
                                if (period == 'AM' && hour == 12) hour = 0;

                                final DateTime deadline =
                                    DateTime(year, month, day, hour, minute);

                                onGoingCubit.createTaskOnServer(
                                    title: onGoingCubit.tasKTitle.text,
                                    description:
                                        onGoingCubit.tasKdescription.text,
                                    deadline: deadline,
                                    projectId: projectId,
                                    assignedTo:
                                        onGoingCubit.tasKAssignedTo.text);
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Add'),
                          ),
                        ],
                      ),
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
        ));
  }
}
