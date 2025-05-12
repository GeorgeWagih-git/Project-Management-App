import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';

class EditTaskButtonWidget extends StatelessWidget {
  final TaskModel task;
  final int projectId;
  final OngoingProjectCubit cubit;

  const EditTaskButtonWidget({
    super.key,
    required this.task,
    required this.projectId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    final deadlineYearController =
        TextEditingController(text: task.deadline.year.toString());
    final deadlineMonthController =
        TextEditingController(text: task.deadline.month.toString());
    final deadlineDayController =
        TextEditingController(text: task.deadline.day.toString());
    final assignedToController = TextEditingController(text: task.assignedTo);

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return MaterialButton(
      minWidth: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: const Color(0xffFED36A),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: const Color(0xff212832),
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const ListTile(
                          title: Text(
                            'Edit Task',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (value) =>
                              value!.isEmpty ? 'Required' : null,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.white),
                            labelText: "Task Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: descriptionController,
                          validator: (value) =>
                              value!.isEmpty ? 'Required' : null,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.white),
                            labelText: "Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          maxLines: null,
                        ),
                        const SizedBox(height: 12),
                        const Text("Deadline",
                            style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: deadlineDayController,
                                decoration:
                                    const InputDecoration(labelText: 'Day'),
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: deadlineMonthController,
                                decoration:
                                    const InputDecoration(labelText: 'Month'),
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: deadlineYearController,
                                decoration:
                                    const InputDecoration(labelText: 'Year'),
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: assignedToController,
                          validator: (value) =>
                              value!.isEmpty ? 'Required' : null,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.white),
                            labelText: "Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          maxLines: null,
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          color: const Color(0xffFED36A),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final int day =
                                  int.parse(deadlineDayController.text);
                              final int month =
                                  int.parse(deadlineMonthController.text);
                              final int year =
                                  int.parse(deadlineYearController.text);

                              final DateTime deadline =
                                  DateTime(year, month, day);

                              cubit.updateTaskOnServer(
                                taskId: task.id,
                                title: nameController.text,
                                description: descriptionController.text,
                                deadline: deadline,
                                projectId: projectId,
                                assignedTo: assignedToController.text,
                              );

                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Save'),
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
      child: const Icon(Icons.edit),
    );
  }
}
