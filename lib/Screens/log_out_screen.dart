import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/welcome_screen.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class LogOutScreen extends StatefulWidget {
  const LogOutScreen({Key? key}) : super(key: key);

  @override
  _LogOutScreenState createState() => _LogOutScreenState();
}

class _LogOutScreenState extends State<LogOutScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  void _logout(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _isEmailValid = email.isNotEmpty;
      _isPasswordValid = password.isNotEmpty;
    });

    if (!_isEmailValid || !_isPasswordValid) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Logging out...")),
    );
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenName: "Log Out",
      showappbar: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              style: TextStyle(color: Color(0xffFED36A)),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Color(0xff455A64),
                errorText: _isEmailValid ? null : "Please enter Email",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: TextStyle(color: Color(0xffFED36A)),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Color(0xff455A64),
                errorText: _isPasswordValid ? null : "Please enter password",
                suffixIcon: IconButton(
                  icon: Icon(
                    color: Color(0xffFED36A),
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFED36A),
                  foregroundColor: Colors.black,
                ),
                onPressed: () => _logout(context),
                child: const Text("Log out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
