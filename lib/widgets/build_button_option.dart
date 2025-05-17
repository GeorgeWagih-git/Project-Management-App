 import 'package:flutter/material.dart';

Widget buildButtonOption(IconData icon, String title, void Function() onTap, {bool isLogout = false}) {
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
        leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
        title: Text(
          title,
          style: TextStyle(color: isLogout ? Colors.red : Colors.black, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
        onTap: () {
          onTap();
        },
      ),
    );
  }