import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_states.dart';
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
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              Form(
                  key: forgetPasswordFormKey,
                  child: Column(
                    children: [
                      const PageHeader(),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller:
                            context.read<SignInCubit>().forgetPasswordEmail,
                        labelText: 'Email',
                        hintText: 'Your Email',
                      ),
                      const SizedBox(height: 16),
                      CustomFormButton(
                        innerText: 'Confirm',
                        onPressed: () {},
                      )
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}
