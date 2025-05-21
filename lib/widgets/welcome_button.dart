import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton(
      {super.key,
      this.buttonText,
      this.destination,
      this.buttonColor,
      this.textbuttonColor});
  final String? buttonText;
  final Widget? destination;
  final Color? buttonColor;
  final Color? textbuttonColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => destination!));
      },
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 25),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
          ),
        ),
        child: Text(buttonText!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textbuttonColor,
              //height: 10,
            )),
      ),
    );
  }
}
