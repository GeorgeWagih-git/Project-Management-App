import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_states.dart';
import 'package:flutter_application_1/widgets/custom_form_button.dart';
import 'package:flutter_application_1/widgets/custom_input_field.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/page_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenName: 'Reset Password',
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              Form(
                key: resetPasswordFormKey,
                child: Column(
                  children: [
                    const PageHeader(
                      assetUrl: 'assets/reset-password.png',
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      controller:
                          context.read<SignInCubit>().forgetPasswordEmail,
                      labelText: 'Email',
                      hintText: 'Your Email',
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      controller:
                          context.read<SignInCubit>().forgetPasswordEmail,
                      labelText: 'OTP',
                      hintText: 'The code was send on your Email',
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      controller:
                          context.read<SignInCubit>().forgetPasswordEmail,
                      labelText: 'New Password',
                      hintText: 'Reset Password',
                      obscureText: true,
                      suffixIcon: true,
                    ),
                    const SizedBox(height: 16),
                    CustomFormButton(
                      innerText: 'Confirm',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
