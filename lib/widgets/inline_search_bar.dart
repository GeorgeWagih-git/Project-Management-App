import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';

class InlineSearchBar extends StatelessWidget {
  const InlineSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        OngoingProjectCubit.get(context).filterProjects(value);
      },
      decoration: InputDecoration(
        hintText: 'Search projects...',
        hintStyle: TextStyle(color: Colors.purple),
        prefixIcon: Icon(Icons.search, color: Colors.purple),
        filled: true,
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
