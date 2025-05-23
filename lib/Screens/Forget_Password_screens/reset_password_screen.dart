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
  PasswordStrength passwordStrength = PasswordStrength.Weak;

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
                        labelText: 'New Password',
                        hintText: 'Reset password',
                        isDense: true,
                        obscureText: true,
                        suffixIcon: true,
                        controller: cubit.resetPasswordNewPassword,
                        onChanged: (value) {
                          setState(() {
                            passwordStrength = getPasswordStrength(value);
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Password Strength: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            passwordStrength == PasswordStrength.Strong
                                ? "Strong 💪"
                                : passwordStrength == PasswordStrength.Medium
                                    ? "Medium ⚠️"
                                    : "Weak ❌",
                            style: TextStyle(
                              color: passwordStrength == PasswordStrength.Strong
                                  ? Colors.green
                                  : passwordStrength == PasswordStrength.Medium
                                      ? Colors.orange
                                      : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      state is ResetPasswordLoading
                          ? const CircularProgressIndicator()
                          : CustomFormButton(
                              innerText: 'Confirm',
                              onPressed: () {
                                if (getPasswordStrength(
                                        cubit.resetPasswordNewPassword.text) !=
                                    PasswordStrength.Strong) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Password is not strong enough')),
                                  );
                                  return;
                                }
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

enum PasswordStrength { Weak, Medium, Strong }

PasswordStrength getPasswordStrength(String password) {
  if (password.length < 6) return PasswordStrength.Weak;

  final hasUppercase = password.contains(RegExp(r'[A-Z]'));
  final hasLowercase = password.contains(RegExp(r'[a-z]'));
  final hasDigits = password.contains(RegExp(r'\d'));
  final hasSpecialCharacters = password.contains(RegExp(r'[!@#\$&*~]'));

  final conditionsMet = [
    hasUppercase,
    hasLowercase,
    hasDigits,
    hasSpecialCharacters,
  ].where((c) => c).length;

  if (conditionsMet >= 3 && password.length >= 8) {
    return PasswordStrength.Strong;
  } else if (conditionsMet >= 2) {
    return PasswordStrength.Medium;
  } else {
    return PasswordStrength.Weak;
  }
}
