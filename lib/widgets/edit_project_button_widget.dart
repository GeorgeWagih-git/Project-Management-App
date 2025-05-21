import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Screens/project_details_screen.dart';

class EditProjectButtonWidget extends StatelessWidget {
  const EditProjectButtonWidget({
    super.key,
    required this.onGoingCubit,
    required this.widget,
  });

  final OngoingProjectCubit onGoingCubit;
  final ProjectDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    final nameController =
        TextEditingController(text: widget.projectClass.name);
    final descriptionController =
        TextEditingController(text: widget.projectClass.projectDetails);
    final deadlineDayController = TextEditingController(
        text: widget.projectClass.deadline.day.toString());
    final deadlineMonthController = TextEditingController(
        text: widget.projectClass.deadline.month.toString());
    final deadlineYearController = TextEditingController(
        text: widget.projectClass.deadline.year.toString());

    final _formKey = GlobalKey<FormState>();

    return MaterialButton(
      minWidth: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: const Color(0xffFED36A),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: const Color(0xff212832),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Update Project',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: nameController,
                        label: 'Project Name',
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descriptionController,
                        validator: (value) =>
                            value!.isEmpty ? 'Required' : null,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Description",
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(height: 12),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Deadline',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: deadlineDayController,
                              label: 'Day',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildTextField(
                              controller: deadlineMonthController,
                              label: 'Month',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildTextField(
                              controller: deadlineYearController,
                              label: 'Year',
                              keyboardType: TextInputType.number,
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

                            onGoingCubit
                                .updateProject(
                              id: widget.projectClass.id,
                              name: nameController.text,
                              description: descriptionController.text,
                              deadline: updatedDeadline,
                            )
                                .then((_) {
                              onGoingCubit.fetchProjectWithTasks(
                                  widget.projectClass.id);
                            });

                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.edit, color: Colors.black),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) => value!.isEmpty ? 'Required' : null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
