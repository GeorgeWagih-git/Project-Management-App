import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ongoingCubit = OngoingProjectCubit.get(context);

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
            String localSelectedAmPm = ongoingCubit.selectedAmPm;

            return StatefulBuilder(
              builder: (context, setState) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  child: Form(
                    key: ongoingCubit.ongoingFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Add New Project",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: ongoingCubit.projectControllername,
                          label: "Project Name",
                        ),
                        const SizedBox(height: 20),
                        const Text("Deadline Date",
                            style: TextStyle(color: Colors.amber)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSmallInput(
                                ongoingCubit.projectControllerdayDead, "Day"),
                            _buildSmallInput(
                                ongoingCubit.projectControllermonthDead,
                                "Month"),
                            _buildSmallInput(
                                ongoingCubit.projectControlleryearDead, "Year"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text("Deadline Time",
                            style: TextStyle(color: Colors.amber)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSmallInput(
                                ongoingCubit.projectControllerHourDead, "Hour"),
                            _buildSmallInput(
                                ongoingCubit.projectControllerMinuteDead,
                                "Minute"),
                            DropdownButton<String>(
                              value: localSelectedAmPm,
                              dropdownColor: const Color(0xff212832),
                              style: const TextStyle(color: Colors.white),
                              items: ['AM', 'PM'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    localSelectedAmPm = newValue;
                                    ongoingCubit.selectedAmPm = newValue;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildDescriptionField(
                            ongoingCubit.projectControllerDiscription),
                        const SizedBox(height: 20),
                        BlocConsumer<OngoingProjectCubit, OngoingProjectStates>(
                          listener: (context, state) {
                            if (state is ProjectCreateSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Project added successfully")),
                              );
                            } else if (state is ProjectCreateFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errMessage)),
                              );
                            }
                          },
                          builder: (context, state) {
                            return state is ProjectCreateLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.amber)
                                : MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    color: const Color(0xffFED36A),
                                    onPressed: () {
                                      if (ongoingCubit
                                          .ongoingFormKey.currentState!
                                          .validate()) {
                                        final int day = int.parse(ongoingCubit
                                            .projectControllerdayDead.text);
                                        final int month = int.parse(ongoingCubit
                                            .projectControllermonthDead.text);
                                        final int year = int.parse(ongoingCubit
                                            .projectControlleryearDead.text);
                                        int hour = int.parse(ongoingCubit
                                            .projectControllerHourDead.text);
                                        final int minute = int.parse(
                                            ongoingCubit
                                                .projectControllerMinuteDead
                                                .text);

                                        if (ongoingCubit.selectedAmPm == 'PM' &&
                                            hour < 12) {
                                          hour += 12;
                                        } else if (ongoingCubit.selectedAmPm ==
                                                'AM' &&
                                            hour == 12) {
                                          hour = 0;
                                        }

                                        final DateTime deadline = DateTime(
                                            year, month, day, hour, minute);

                                        ongoingCubit.createProjectonDatabase(
                                          name: ongoingCubit
                                              .projectControllername.text,
                                          description: ongoingCubit
                                              .projectControllerDiscription
                                              .text,
                                          deadline: deadline,
                                        );

                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text('Add'),
                                  );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: const Icon(Icons.add, color: Colors.black),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      validator: (value) => value!.isEmpty ? "required" : null,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  Widget _buildSmallInput(TextEditingController controller, String label) {
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
        validator: (value) => value!.isEmpty ? "required" : null,
      ),
    );
  }

  Widget _buildDescriptionField(TextEditingController controller) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 100, maxHeight: 300),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: "Description",
          labelStyle: const TextStyle(color: Colors.amber),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
        validator: (value) => value!.isEmpty ? "required" : null,
      ),
    );
  }
}
