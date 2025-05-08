import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
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
    return BlocConsumer<OngoingProjectCubit, OngoingProjectStates>(
        listener: (context, state) {
      if (state is SignUpSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please confirm your email")));
      } else if (state is SignUpFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errMessage)));
      }
    }, builder: (context, state) {
      return CustomScaffold(
        screenName: 'Sign Up',
        child: SingleChildScrollView(
          child: Form(
            key: context.read<OngoingProjectCubit>().signUpFormKey,
            child: Column(
              children: [
                //const PageHeader(),
                //! Image
                const PickImageWidget(),
                const SizedBox(height: 16),
                //! Name
                CustomInputField(
                  labelText: 'Name',
                  hintText: 'Your name',
                  isDense: true,
                  controller: context.read<OngoingProjectCubit>().signUpName,
                ),
                const SizedBox(height: 16),
                //!Email
                CustomInputField(
                  labelText: 'Email',
                  hintText: 'Your email',
                  isDense: true,
                  controller: context.read<OngoingProjectCubit>().signUpEmail,
                ),
                const SizedBox(height: 16),
                //! Phone Number
                CustomInputField(
                  labelText: 'Phone number',
                  hintText: 'Your phone number ex:01234567890',
                  isDense: true,
                  controller:
                      context.read<OngoingProjectCubit>().signUpPhoneNumber,
                ),
                const SizedBox(height: 16),
                //! Password
                CustomInputField(
                  labelText: 'Password',
                  hintText: 'Your password',
                  isDense: true,
                  obscureText: true,
                  suffixIcon: true,
                  controller:
                      context.read<OngoingProjectCubit>().signUpPassword,
                ),
                //! Confirm Password
                CustomInputField(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Your password',
                  isDense: true,
                  obscureText: true,
                  suffixIcon: true,
                  controller:
                      context.read<OngoingProjectCubit>().confirmPassword,
                ),
                const SizedBox(height: 22),
                //!Sign Up Button
                state is SignUpLoading
                    ? const CircularProgressIndicator()
                    : CustomFormButton(
                        innerText: 'Signup',
                        onPressed: () {
                          context.read<OngoingProjectCubit>().signUp();
                        },
                      ),
                const SizedBox(height: 18),
                //! Already have an account widget
                const AlreadyHaveAnAccount(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }
}
