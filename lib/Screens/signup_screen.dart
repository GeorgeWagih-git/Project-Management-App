import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/welcome_screen.dart';
import 'package:flutter_application_1/widgets/custom_scaffold.dart';
import 'package:icons_plus/icons_plus.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formsignupkey = GlobalKey<FormState>();
  bool isagree = true;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 50, 25, 50),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formsignupkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Let's Start",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text('Full name'),
                          hintText: 'Enter full name',
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(103, 0, 0, 0),
                          ),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(103, 0, 0, 0),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
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
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "password is requird";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          label: Text('Password'),
                          hintText: 'Enter password',
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(103, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(103, 0, 0, 0),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isagree,
                            onChanged: (bool? value) {
                              setState(() {
                                isagree = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text(
                            'I agree to the processing of ',
                            style: TextStyle(
                              color: const Color.fromARGB(103, 0, 0, 0),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeScreen()));
                            },
                            child: Text(
                              'Personal data',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formsignupkey.currentState!.validate() &&
                                isagree) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                            } else if (!isagree) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Please agree to the processing of personal data')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Divider(
                            thickness: 0.7,
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: Text(
                              'Sign Up wirth',
                              style: TextStyle(
                                color: const Color.fromARGB(103, 0, 0, 0),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 0.7,
                          )),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesome.facebook_brand,
                            size: 30,
                            color: Colors.blue,
                          ),
                          Icon(
                            FontAwesome.twitter_brand,
                            size: 30,
                            color: Colors.blue,
                          ),
                          Icon(
                            FontAwesome.google_brand,
                            size: 30,
                            color: Colors.blue,
                          ),
                          Icon(
                            FontAwesome.instagram_brand,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
