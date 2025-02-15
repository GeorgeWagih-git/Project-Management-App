import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_scaffold.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formloginkey = GlobalKey<FormState>();
  bool isobscured = true;
  bool rememberPassword = true;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              )),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 50, 25, 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: SingleChildScrollView(
                child: Form(
                    key: formloginkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            label: Text('Email'),
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(103, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(103, 0, 0, 0),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (formloginkey.currentState!.validate() &&
                                  rememberPassword) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'you will recieve a confirmation link in your Email',
                                  ),
                                ));
                              }
                            },
                            child: Text(
                              'Send Email',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
