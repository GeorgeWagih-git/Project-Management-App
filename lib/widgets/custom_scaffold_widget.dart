import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/calender_screen.dart';
import 'package:flutter_application_1/Screens/chat_screen.dart';
import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/Screens/notfifcations_screen.dart';
import 'package:flutter_application_1/widgets/build_nav_item.dart';

class CustomScaffold extends StatefulWidget {
  CustomScaffold({
    super.key,
    required this.child,
    this.screenName = '',
    this.showappbar = true,
    this.showhomebottombar = false,
    this.homeSelected = false,
    this.chatSelected = false,
    this.calenderSelected = false,
    this.notificationSelected = false,
    this.showBackButton = true,
  });
  final Widget? child;
  final bool? showappbar;
  final bool? showhomebottombar;
  final String? screenName;
  bool homeSelected;
  bool calenderSelected;
  bool chatSelected;
  bool notificationSelected;
  bool showBackButton;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  bool back = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.showhomebottombar!
          ? BottomAppBar(
              color: Color(0xff263238),
              elevation: 0,
              shape: CircularNotchedRectangle(),
              notchMargin: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.homeSelected = true;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: BuildNavItem(
                      icon: Icons.home,
                      label: "Home",
                      isSelected: widget.homeSelected,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.chatSelected = true;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen()));
                    },
                    child: BuildNavItem(
                      icon: Icons.chat,
                      label: "Chat",
                      isSelected: widget.chatSelected,
                    ),
                  ),
                  SizedBox(width: 40), // مسافة لموازنة الـ FloatingActionButton
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.calenderSelected = true;
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalenderScreen()));
                    },
                    child: BuildNavItem(
                        icon: Icons.calendar_today,
                        label: "Calendar",
                        isSelected: widget.calenderSelected),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.notificationSelected = true;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationsScreen()));
                    },
                    child: BuildNavItem(
                        icon: Icons.notifications,
                        label: "Notification",
                        isSelected: widget.notificationSelected),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButton: widget.showhomebottombar!
          ? FloatingActionButton(
              backgroundColor: Color(0xffFED36A),
              onPressed: () {},
              child: Icon(Icons.add, color: Colors.black),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      appBar: widget.showappbar!
          ? AppBar(
              automaticallyImplyLeading: false,
              leading: widget.showBackButton
                  ? IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context); // الرجوع إلى الشاشة السابقة
                      },
                    )
                  : null,
              title: Center(
                child: Text(
                  widget.screenName!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
            child: widget.child!,
          )
        ],
      ),
      // Stack
    ); // Scaffold;
  }
}
