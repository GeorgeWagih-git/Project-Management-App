import 'package:flutter/material.dart';

class NotificationsToggle extends StatefulWidget {
  final String title;

  NotificationsToggle({required this.title});

  @override
  _NotificationsToggleState createState() => _NotificationsToggleState();
}

class _NotificationsToggleState extends State<NotificationsToggle> {
  bool isSwitched = false;

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
        title: Text( "Notifications", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        trailing: Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
        ),
      ),
    );
  }
}