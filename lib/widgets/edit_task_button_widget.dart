import 'package:flutter/material.dart';

class EditTaskButtonWidget extends StatelessWidget {
  const EditTaskButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController deadlineYearController =
        TextEditingController();
    final TextEditingController deadlineMonthController =
        TextEditingController();
    final TextEditingController deadlineDayController = TextEditingController();
    final TextEditingController assignedtoController = TextEditingController();
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
                            'Update Task',
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
                        const SizedBox(height: 20),
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
                                  controller: assignedtoController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.white),
                                    labelText: "Assigned To ",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                  autofocus: true,
                                ),
                              ),
                            ]),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          color: const Color(0xffFED36A),
                          onPressed: () {},
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
