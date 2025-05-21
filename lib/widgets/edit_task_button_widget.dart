import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';

class EditTaskButtonWidget extends StatefulWidget {
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
  State<EditTaskButtonWidget> createState() => _EditTaskButtonWidgetState();
}

class _EditTaskButtonWidgetState extends State<EditTaskButtonWidget> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController assignedToController;
  late TextEditingController deadlineYearController;
  late TextEditingController deadlineMonthController;
  late TextEditingController deadlineDayController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
    assignedToController = TextEditingController(text: widget.task.assignedTo);
    deadlineYearController =
        TextEditingController(text: widget.task.deadline.year.toString());
    deadlineMonthController =
        TextEditingController(text: widget.task.deadline.month.toString());
    deadlineDayController =
        TextEditingController(text: widget.task.deadline.day.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    assignedToController.dispose();
    deadlineYearController.dispose();
    deadlineMonthController.dispose();
    deadlineDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  title:
                      Text('Edit Task', style: TextStyle(color: Colors.white)),
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Task Name",
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
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
                TextFormField(
                  controller: assignedToController,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Assigned To",
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                const SizedBox(height: 12),
                const Text("Deadline", style: TextStyle(color: Colors.white)),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: deadlineDayController,
                        decoration: const InputDecoration(labelText: 'Day'),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: deadlineMonthController,
                        decoration: const InputDecoration(labelText: 'Month'),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: deadlineYearController,
                        decoration: const InputDecoration(labelText: 'Year'),
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final DateTime deadline = DateTime(
                        int.parse(deadlineYearController.text),
                        int.parse(deadlineMonthController.text),
                        int.parse(deadlineDayController.text),
                      );

                      await widget.cubit.updateTaskOnServer(
                        taskId: widget.task.id,
                        title: nameController.text,
                        description: descriptionController.text,
                        deadline: deadline,
                        assignedTo: assignedToController.text,
                        projectId: widget.projectId,
                      );

                      Navigator.pop(
                        context,
                        TaskModel(
                          id: widget.task.id,
                          title: nameController.text,
                          description: descriptionController.text,
                          deadline: deadline,
                          assignedTo: assignedToController.text,
                          isDone: widget.task.isDone,
                          projectId: widget.task.projectId,
                          createdDate: widget.task.createdDate,
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
}
