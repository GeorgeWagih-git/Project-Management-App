import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/calender_screen.dart';
import 'package:flutter_application_1/Screens/chat_screen.dart';
import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/Screens/settings_screen.dart';
import 'package:flutter_application_1/widgets/build_nav_item.dart';

// ignore: must_be_immutable
class CustomScaffoldWidget extends StatefulWidget {
  CustomScaffoldWidget({
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

  final Widget child;
  final bool? showappbar;
  final bool? showhomebottombar;
  final String? screenName;
  bool homeSelected;
  bool calenderSelected;
  bool chatSelected;
  bool notificationSelected;
  bool showBackButton;

  @override
  State<CustomScaffoldWidget> createState() => _CustomScaffoldWidgetState();
}

class _CustomScaffoldWidgetState extends State<CustomScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212832),
      extendBodyBehindAppBar: true,
      appBar: widget.showappbar!
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: widget.showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    )
                  : null,
              title: Center(
                child: Text(
                  widget.screenName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width < 600
                  ? double.infinity
                  : 600,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: widget.child,
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.showhomebottombar!
          ? BottomAppBar(
              color: const Color(0xff263238),
              elevation: 0,
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context,
                    icon: Icons.home,
                    label: 'Home',
                    selected: widget.homeSelected,
                    screen: const HomeScreen(),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.chat,
                    label: 'Chat',
                    selected: widget.chatSelected,
                    screen: const ChatScreen(),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Calendar',
                    selected: widget.calenderSelected,
                    screen: CalenderScreen(),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.settings,
                    label: 'Settings',
                    selected: widget.notificationSelected,
                    screen: SettingsScreen(),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool selected,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: BuildNavItem(
        icon: icon,
        label: label,
        isSelected: selected,
      ),
    );
  }
}
