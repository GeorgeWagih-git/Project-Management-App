import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsToggle extends StatefulWidget {
  final String title;

  NotificationsToggle({required this.title});

  @override
  _NotificationsToggleState createState() => _NotificationsToggleState();
}

class _NotificationsToggleState extends State<NotificationsToggle> {
  bool isSwitched = false;
  final NotificationsService _notificationsService = NotificationsService();

  @override
  void initState() {
    super.initState();
    _initializeToggle();
  }

  Future<void> _initializeToggle() async {
    // Step 3: Ensure notifications are initialized before usage
    await _notificationsService.initNotifications();

    // Load saved state
    bool enabled = await _notificationsService.areNotificationsEnabled();
    setState(() {
      isSwitched = enabled;
    });
  }

  void _onToggleChanged(bool value) async {
    setState(() {
      isSwitched = value;
    });
    final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('notifications_enabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xffFED36A),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.black),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        trailing: Switch(
          value: isSwitched,
          onChanged: _onToggleChanged,
        ),
      ),
    );
  }
}
