import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final assignedToController = TextEditingController(text: task.assignedTo);
    final deadlineYearController =
        TextEditingController(text: task.deadline.year.toString());
    final deadlineMonthController =
        TextEditingController(text: task.deadline.month.toString());
    final deadlineDayController =
        TextEditingController(text: task.deadline.day.toString());

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Edit Task',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: nameController,
                  label: "Task Name",
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: descriptionController,
                  label: "Description",
                  maxLines: 4,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: assignedToController,
                  label: "Assigned To (Email)",
                ),
                const SizedBox(height: 16),
                const Text("Deadline", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberField(
                        controller: deadlineDayController,
                        label: 'Day',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildNumberField(
                        controller: deadlineMonthController,
                        label: 'Month',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildNumberField(
                        controller: deadlineYearController,
                        label: 'Year',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: const Color(0xffFED36A),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final deadline = DateTime(
                        int.parse(deadlineYearController.text),
                        int.parse(deadlineMonthController.text),
                        int.parse(deadlineDayController.text),
                      );

                      await cubit.updateTaskOnServer(
                        taskId: task.id,
                        title: nameController.text,
                        description: descriptionController.text,
                        deadline: deadline,
                        assignedTo: assignedToController.text,
                        projectId: projectId,
                      );

                      Navigator.pop(
                        context,
                        TaskModel(
                          id: task.id,
                          title: nameController.text,
                          description: descriptionController.text,
                          deadline: deadline,
                          assignedTo: assignedToController.text,
                          isDone: task.isDone,
                          projectId: projectId, // صححناها هنا
                          createdDate: task.createdDate,
                        ),
                      );
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
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) => value!.isEmpty ? 'Required' : null,
      style: const TextStyle(color: Colors.white),
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) => value!.isEmpty ? 'Required' : null,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
