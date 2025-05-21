import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingProjectCubit, OngoingProjectStates>(
      builder: (context, state) {
        List<ProjectClass> projects = [];

        if (state is ProjectsSuccessfulState) {
          projects = state.project;
        }

        List<ProjectClass> sortedList = List.from(projects)
          ..sort((a, b) => a.deadline.compareTo(b.deadline));

        List<ProjectClass> filteredList = sortedList.where((project) {
          bool matchesSearch = searchQuery.isEmpty ||
              project.name.toLowerCase().contains(searchQuery.toLowerCase());
          bool matchesDate = selectedDate == null ||
              DateFormat('yyyy-MM-dd').format(project.deadline) ==
                  DateFormat('yyyy-MM-dd').format(selectedDate!);
          return matchesSearch && matchesDate;
        }).toList();

        return CustomScaffold(
          calenderSelected: true,
          showhomebottombar: true,
          screenName: 'Calendar',
          showBackButton: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Color(0xff6F8793)),
                          prefixIcon: Icon(Icons.search, color: Color(0xff6F8793)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: Color(0xff455A64),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFED36A),
                        foregroundColor: Colors.black,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15),
                      ),
                      child: Icon(Icons.calendar_today),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final project = filteredList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Colors.blueGrey.shade700,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: Colors.grey, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    'Due on: ${DateFormat('dd MMMM yyyy – hh:mm a').format(project.deadline)}',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
