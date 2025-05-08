import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/signup_screen.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account ? ',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff939393),
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ),
              ),
            },
            child: const Text(
              'Sign-up',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff748288),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
