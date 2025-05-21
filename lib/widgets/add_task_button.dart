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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: const Color(0xffFED36A),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: const Color(0xff212832),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Add New Task",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: onGoingCubit.tasKTitle,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Task Name",
                        labelStyle: const TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Deadline Date",
                        style: TextStyle(color: Colors.amber)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDateField(onGoingCubit.tasKDay, 'Day'),
                        _buildDateField(onGoingCubit.tasKMonth, 'Month'),
                        _buildDateField(onGoingCubit.tasKYear, 'Year'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Deadline Time",
                        style: TextStyle(color: Colors.amber)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTimeField(
                            onGoingCubit.taskHourController, 'Hour'),
                        _buildTimeField(
                            onGoingCubit.taskMinuteController, 'Minute'),
                        DropdownButton<String>(
                          value: onGoingCubit.taskPeriod,
                          dropdownColor: const Color(0xff212832),
                          items: ['AM', 'PM'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              onGoingCubit.taskPeriod = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 100, maxHeight: 300),
                      child: TextFormField(
                        controller: onGoingCubit.tasKdescription,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Description",
                          labelStyle: const TextStyle(color: Colors.amber),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: onGoingCubit.tasKAssignedTo,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Assigned To (Email)',
                        labelStyle: TextStyle(color: Colors.amber),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: const Color(0xffFED36A),
                      onPressed: () {
                        if (_allFieldsValid(context)) {
                          int day = int.parse(onGoingCubit.tasKDay.text);
                          int month = int.parse(onGoingCubit.tasKMonth.text);
                          int year = int.parse(onGoingCubit.tasKYear.text);
                          int hour = int.tryParse(
                                  onGoingCubit.taskHourController.text) ??
                              0;
                          int minute = int.tryParse(
                                  onGoingCubit.taskMinuteController.text) ??
                              0;

                          String period = onGoingCubit.taskPeriod;
                          if (period == 'PM' && hour < 12) hour += 12;
                          if (period == 'AM' && hour == 12) hour = 0;

                          final DateTime deadline =
                              DateTime(year, month, day, hour, minute);

                          onGoingCubit.createTaskOnServer(
                            title: onGoingCubit.tasKTitle.text,
                            description: onGoingCubit.tasKdescription.text,
                            deadline: deadline,
                            projectId: projectId,
                            assignedTo: onGoingCubit.tasKAssignedTo.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            });
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return SizedBox(
      width: 90,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.amber),
        ),
      ),
    );
  }

  Widget _buildTimeField(TextEditingController controller, String label) {
    return SizedBox(
      width: 80,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.amber),
        ),
      ),
    );
  }

  bool _allFieldsValid(BuildContext context) {
    if (onGoingCubit.tasKTitle.text.isEmpty ||
        onGoingCubit.tasKDay.text.isEmpty ||
        onGoingCubit.tasKMonth.text.isEmpty ||
        onGoingCubit.tasKYear.text.isEmpty ||
        onGoingCubit.taskHourController.text.isEmpty ||
        onGoingCubit.taskMinuteController.text.isEmpty ||
        onGoingCubit.tasKdescription.text.isEmpty ||
        onGoingCubit.tasKAssignedTo.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields")),
      );
      return false;
    }
    return true;
  }
}
