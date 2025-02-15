import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/login_screen.dart';
import 'package:flutter_application_1/Screens/signup_screen.dart';
import 'package:flutter_application_1/widgets/custom_scaffold.dart';
import 'package:flutter_application_1/widgets/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Welcome !\n",
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w600,
                            )),
                        TextSpan(
                          text: "\nEnter personal details to your account",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Expanded(
                        child: WelcomeButton(
                      buttonText: 'Log  in',
                      destination: LoginScreen(),
                      buttonColor: Colors.transparent,
                      textbuttonColor: Colors.white,
                    )),
                    Expanded(
                        child: WelcomeButton(
                      buttonText: "sign Up",
                      destination: SignupScreen(),
                      buttonColor: Colors.white,
                      textbuttonColor: Colors.blueAccent,
                    )),
                  ],
                ),
              )),
        ],
      ),
    ); // Scaffold
  }
}
