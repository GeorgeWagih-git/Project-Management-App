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
    final TextEditingController nameController =
        TextEditingController(text: widget.projectClass.name);
    final TextEditingController descriptionController =
        TextEditingController(text: widget.projectClass.projectDetails);
    final TextEditingController deadlineYearController = TextEditingController(
        text: widget.projectClass.deadline.year.toString());
    final TextEditingController deadlineMonthController = TextEditingController(
        text: widget.projectClass.deadline.month.toString());
    final TextEditingController deadlineDayController = TextEditingController(
        text: widget.projectClass.deadline.day.toString());

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    key: _formKey,
                    child: Column(
                      children: [
                        const ListTile(
                          title: Text(
                            'Update Project',
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
                            labelText: "Project Name",
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
                        const SizedBox(height: 20),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          color: const Color(0xffFED36A),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final updatedDeadline = DateTime(
                                int.parse(deadlineYearController.text),
                                int.parse(deadlineMonthController.text),
                                int.parse(deadlineDayController.text),
                              );

                              onGoingCubit.updateProject(
                                id: widget.projectClass.id,
                                name: nameController.text,
                                description: descriptionController.text,
                                deadline: updatedDeadline,
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
