import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_states.dart';

import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/widgets/custom_form_button.dart';
import 'package:flutter_application_1/widgets/custom_input_field.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/dont_have_an_account_widget.dart';
import 'package:flutter_application_1/widgets/forget_password_widget.dart';
import 'package:flutter_application_1/widgets/page_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> signInFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      showBackButton: false,
      screenName: 'Sign In',
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Welcome")));
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth = constraints.maxWidth;

              double contentWidth = maxWidth > 600 ? 500 : maxWidth * 0.9;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Form(
                      key: signInFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const PageHeader(assetUrl: 'assets/person.png'),
                          const SizedBox(height: 24),
                          CustomInputField(
                            labelText: 'Email',
                            hintText: 'Your email',
                            controller: context.read<SignInCubit>().signInEmail,
                          ),
                          const SizedBox(height: 16),
                          CustomInputField(
                            labelText: 'Password',
                            hintText: 'Your password',
                            obscureText: true,
                            suffixIcon: true,
                            controller:
                                context.read<SignInCubit>().signInPassword,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: ForgetPasswordWidget(
                                size: MediaQuery.of(context).size),
                          ),
                          const SizedBox(height: 24),
                          state is SignInLoading
                              ? const CircularProgressIndicator()
                              : CustomFormButton(
                                  innerText: 'Sign In',
                                  onPressed: () {
                                    context.read<SignInCubit>().signIn();
                                  },
                                ),
                          const SizedBox(height: 18),
                          DontHaveAnAccountWidget(
                              size: MediaQuery.of(context).size),
                          /*const SizedBox(height: 20),
                          CustomFormButton(
                            innerText: 'Sign In offline',
                            onPressed: () {
                              navigateTo(context, HomeScreen());
                            },
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
