import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Forget_Password_cubit/forget_password_cubit.dart';
import 'package:flutter_application_1/Cubits/Forget_Password_cubit/forget_password_states.dart';
import 'package:flutter_application_1/Screens/Forget_Password_screens/reset_password_screen.dart';
import 'package:flutter_application_1/core/functions/navigate_to.dart';
import 'package:flutter_application_1/widgets/custom_form_button.dart';
import 'package:flutter_application_1/widgets/custom_input_field.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/page_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenName: 'Forget Password',
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is SendResetCodeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("you recived an OTP in your inbox")));
            navigateTo(context, ResetPasswordScreen());
          } else if (state is SendResetCodeFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Form(
                  key: forgetPasswordFormKey,
                  child: Column(
                    children: [
                      const PageHeader(
                        assetUrl: 'assets/forgot-password.png',
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: context
                            .read<ForgetPasswordCubit>()
                            .forgetPasswordEmail,
                        labelText: 'Email',
                        hintText: 'Your Email',
                      ),
                      const SizedBox(height: 16),
                      state is SendResetCodeLoading
                          ? const CircularProgressIndicator()
                          : CustomFormButton(
                              innerText: 'Confirm',
                              onPressed: () {
                                if (forgetPasswordFormKey.currentState!
                                    .validate()) {
                                  context
                                      .read<ForgetPasswordCubit>()
                                      .sendResetCode(context
                                          .read<ForgetPasswordCubit>()
                                          .forgetPasswordEmail
                                          .text);
                                }
                              },
                            ),
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}
