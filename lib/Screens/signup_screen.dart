import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Sign_Up_cubit/sign_up_cubit.dart';
import 'package:flutter_application_1/Cubits/Sign_Up_cubit/sign_up_states.dart';
import 'package:flutter_application_1/widgets/already_have_an_account.dart';
import 'package:flutter_application_1/widgets/custom_form_button.dart';
import 'package:flutter_application_1/widgets/custom_input_field.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/pick_image_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpStates>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please confirm your email")));
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return CustomScaffoldWidget(
          screenName: 'Sign Up',
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final isWideScreen = screenWidth >= 600;

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: isWideScreen ? 500 : double.infinity),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Form(
                      key: context.read<SignUpCubit>().signUpFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const PickImageWidget(),
                          const SizedBox(height: 16),
                          CustomInputField(
                            labelText: 'Name',
                            hintText: 'Your name',
                            isDense: true,
                            controller: context.read<SignUpCubit>().signUpName,
                          ),
                          const SizedBox(height: 16),
                          CustomInputField(
                            labelText: 'User Name',
                            hintText: 'Your user name',
                            isDense: true,
                            controller:
                                context.read<SignUpCubit>().signUpUserName,
                          ),
                          const SizedBox(height: 16),
                          CustomInputField(
                            labelText: 'Email',
                            hintText: 'Your email',
                            isDense: true,
                            controller: context.read<SignUpCubit>().signUpEmail,
                          ),
                          const SizedBox(height: 16),
                          CustomInputField(
                            labelText: 'Phone number',
                            hintText: 'Your phone number ex:01234567890',
                            isDense: true,
                            controller:
                                context.read<SignUpCubit>().signUpPhoneNumber,
                          ),
                          const SizedBox(height: 16),
                          CustomInputField(
                            labelText: 'Password',
                            hintText: 'Your password',
                            isDense: true,
                            obscureText: true,
                            suffixIcon: true,
                            controller:
                                context.read<SignUpCubit>().signUpPassword,
                          ),
                          const SizedBox(height: 16),
                          CustomInputField(
                            labelText: 'Your Bio',
                            hintText: 'bio',
                            isDense: true,
                            controller: context.read<SignUpCubit>().bio,
                          ),
                          const SizedBox(height: 22),
                          state is SignUpLoading
                              ? const CircularProgressIndicator()
                              : CustomFormButton(
                                  innerText: 'Signup',
                                  onPressed: () {
                                    context.read<SignUpCubit>().signUp();
                                  },
                                ),
                          const SizedBox(height: 18),
                          const AlreadyHaveAnAccount(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
