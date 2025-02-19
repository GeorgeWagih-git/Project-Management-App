import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/build_nav_item.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key, required this.child, this.showappbar = true});
  final Widget? child;
  final bool? showappbar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff263238),
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BuildNavItem(icon: Icons.home, label: "Home", isSelected: true),
            BuildNavItem(icon: Icons.chat, label: "Chat", isSelected: false),
            SizedBox(width: 40), // مسافة لموازنة الـ FloatingActionButton
            BuildNavItem(
                icon: Icons.calendar_today,
                label: "Calendar",
                isSelected: false),
            BuildNavItem(
                icon: Icons.notifications,
                label: "Notification",
                isSelected: false),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFED36A),
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: showappbar!
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            )
          : null,

      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Color(0xff212832)),
          ),
          SafeArea(
            child: child!,
          )
        ],
      ),
      // Stack
    ); // Scaffold;
  }
}
