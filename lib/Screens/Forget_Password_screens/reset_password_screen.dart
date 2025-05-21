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
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      screenName: 'Reset Password',
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password Changed Successfully")),
            );
            navigateTo(context, const SigninScreen());
          } else if (state is ResetPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ForgetPasswordCubit>();
          final screenWidth = MediaQuery.of(context).size.width;
          final isWideScreen = screenWidth >= 600;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: isWideScreen ? 500 : double.infinity),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Form(
                  key: resetPasswordFormKey,
                  child: Column(
                    children: [
                      const PageHeader(assetUrl: 'assets/reset-password.png'),
                      const SizedBox(height: 24),
                      CustomInputField(
                        controller: cubit.resetPasswordEmail,
                        labelText: 'Email',
                        hintText: 'Your Email',
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: cubit.resetPasswordToken,
                        labelText: 'OTP',
                        hintText: 'The code was sent to your email',
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: cubit.resetPasswordNewPassword,
                        labelText: 'New Password',
                        hintText: 'Reset Password',
                        obscureText: true,
                        suffixIcon: true,
                      ),
                      const SizedBox(height: 24),
                      state is ResetPasswordLoading
                          ? const CircularProgressIndicator()
                          : CustomFormButton(
                              innerText: 'Confirm',
                              onPressed: () {
                                if (resetPasswordFormKey.currentState!
                                    .validate()) {
                                  cubit.resetPassword(
                                    email: cubit.resetPasswordEmail.text,
                                    token: cubit.resetPasswordToken.text,
                                    newPassword:
                                        cubit.resetPasswordNewPassword.text,
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
