import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';

class InlineTaskSearchBar extends StatelessWidget {
  const InlineTaskSearchBar({super.key, required this.projectid});
  final int projectid;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        OngoingProjectCubit.get(context).filterTasks(value, projectid);
      },
      decoration: InputDecoration(
        hintText: 'Search tasks...',
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.search, color: Colors.white),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
