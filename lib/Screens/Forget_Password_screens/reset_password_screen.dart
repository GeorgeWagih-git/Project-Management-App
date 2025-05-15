import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Forget_Password_cubit/forget_password_cubit.dart';
import 'package:flutter_application_1/Cubits/Forget_Password_cubit/forget_password_states.dart';
import 'package:flutter_application_1/Screens/signin_screen.dart';
import 'package:flutter_application_1/core/functions/navigate_to.dart';
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
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Password Changed Successfully")));
            navigateTo(context, SigninScreen());
          } else if (state is ResetPasswordFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
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
                      controller: context
                          .read<ForgetPasswordCubit>()
                          .resetPasswordEmail,
                      labelText: 'Email',
                      hintText: 'Your Email',
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      controller: context
                          .read<ForgetPasswordCubit>()
                          .resetPasswordToken,
                      labelText: 'OTP',
                      hintText: 'The code was send on your Email',
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      controller: context
                          .read<ForgetPasswordCubit>()
                          .resetPasswordNewPassword,
                      labelText: 'New Password',
                      hintText: 'Reset Password',
                      obscureText: true,
                      suffixIcon: true,
                    ),
                    const SizedBox(height: 16),
                    state is ResetPasswordLoading
                        ? const CircularProgressIndicator()
                        : CustomFormButton(
                            innerText: 'Confirm',
                            onPressed: () {
                              if (resetPasswordFormKey.currentState!
                                  .validate()) {
                                context
                                    .read<ForgetPasswordCubit>()
                                    .resetPassword(
                                      email: context
                                          .read<ForgetPasswordCubit>()
                                          .resetPasswordEmail
                                          .text,
                                      token: context
                                          .read<ForgetPasswordCubit>()
                                          .resetPasswordToken
                                          .text,
                                      newPassword: context
                                          .read<ForgetPasswordCubit>()
                                          .resetPasswordNewPassword
                                          .text,
                                    );
                              }
                            },
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
