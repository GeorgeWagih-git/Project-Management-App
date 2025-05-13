import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_states.dart';

import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/core/functions/navigate_to.dart';
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
    Size size = MediaQuery.of(context).size;
    return CustomScaffold(
      screenName: 'Sign In',
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Welcomr")));
            navigateTo(context, HomeScreen());
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const PageHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: signInFormKey,
                      child: Column(
                        children: [
                          //!Email
                          CustomInputField(
                            labelText: 'Email',
                            hintText: 'Your email',
                            controller: context.read<SignInCubit>().signInEmail,
                          ),
                          const SizedBox(height: 16),
                          //!Password
                          CustomInputField(
                            labelText: 'Password',
                            hintText: 'Your password',
                            obscureText: true,
                            suffixIcon: true,
                            controller:
                                context.read<SignInCubit>().signInPassword,
                          ),
                          const SizedBox(height: 16),
                          //! Forget password?
                          ForgetPasswordWidget(size: size),
                          const SizedBox(height: 20),
                          //!Sign In Button
                          state is SignInLoading
                              ? const CircularProgressIndicator()
                              : CustomFormButton(
                                  innerText: 'Sign In',
                                  onPressed: () {
                                    context.read<SignInCubit>().signIn();
                                  },
                                ),
                          const SizedBox(height: 18),
                          //! Dont Have An Account ?
                          DontHaveAnAccountWidget(size: size),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
