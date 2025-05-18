import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/signin_screen.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/build_button_option.dart';
import 'package:flutter_application_1/Screens/edit_profile_screen.dart';
import 'package:flutter_application_1/Classes/notifications_toggle.dart';
import 'package:flutter_application_1/Screens/change_password_screen.dart';
import 'package:flutter_application_1/Classes/user_model.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
            () async {
              bool confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout Confirmation'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Log Out'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await AppPrefs.logout();

                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SigninScreen()),
                    (route) => false,
                  );
                }
              }
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }
}
