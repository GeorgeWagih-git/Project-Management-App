import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/Classes/change_password_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  void _changePassword() {
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    final loginPassword = SignInCubit.get(context).signInPassword;

    String? errorMessage;

    if (oldPassword.isEmpty) {
      errorMessage = 'Please enter your old password';
    }
    if (_oldPasswordController != loginPassword) {
      errorMessage = 'Old password is incorrect';
    }
    if (newPassword.isEmpty) {
      errorMessage = 'Please enter a new password';
    }
    if (newPassword == oldPassword) {
      errorMessage = 'New password cannot be the same as the old password';
    }
    if (confirmPassword.isEmpty) {
      errorMessage = 'Please confirm your new password';
    }
    if (confirmPassword != newPassword) {
      errorMessage = 'Passwords do not match';
    }

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }

    // Call the API to change the password here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password changed successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenName: "Change Password",
      showappbar: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              changePasswordField(
                label: 'Old Password',
                controller: _oldPasswordController,
                obscureText: _obscureOldPassword,
                toggleVisibility: () {
                  setState(() {
                    _obscureOldPassword = !_obscureOldPassword;
                  });
                },
              ),
              SizedBox(height: 16),
              changePasswordField(
                label: 'New Password',
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                toggleVisibility: () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                },
              ),
              SizedBox(height: 16),
              changePasswordField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                toggleVisibility: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFED36A),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: _changePassword,
                  child: Text('Change Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
