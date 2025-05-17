import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/build_button_option.dart';
import 'package:flutter_application_1/Screens/edit_profile_screen.dart';
import 'package:flutter_application_1/Screens/log_out_screen.dart';
import 'package:flutter_application_1/Classes/notifications_toggle.dart';
import 'package:flutter_application_1/Screens/change_password_screen.dart';
import 'package:flutter_application_1/Classes/user_model.dart';

class SettingsScreen extends StatelessWidget {
  late final UserModel user;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenName: "Settings",
      showappbar: true,
      child: ListView(
        children: [
          buildButtonOption(
            Icons.edit,
            'Edit Profile',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
          buildButtonOption(
            Icons.password,
            'Change Password',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            },
          ),
          NotificationsToggle(title: "Notifications"),
          buildButtonOption(
            Icons.logout,
            'Logout',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogOutScreen()),
              );
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }
}
