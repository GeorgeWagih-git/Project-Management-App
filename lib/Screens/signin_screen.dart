import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_states.dart';
import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/core/functions/navigate_to.dart';
import 'package:flutter_application_1/widgets/custom_form_button.dart';
import 'package:flutter_application_1/widgets/custom_input_field.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_application_1/widgets/dont_have_an_account_widget.dart';
import 'package:flutter_application_1/widgets/forget_password_widget.dart';
import 'package:flutter_application_1/widgets/page_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScaffold(
      screenName: 'Sign In',
      child: BlocConsumer<OngoingProjectCubit, OngoingProjectStates>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("succefull")));
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
                      key: context.read<OngoingProjectCubit>().signInFormKey,
                      child: Column(
                        children: [
                          //!Email
                          CustomInputField(
                            labelText: 'Email',
                            hintText: 'Your email',
                            controller:
                                context.read<OngoingProjectCubit>().signInEmail,
                          ),
                          const SizedBox(height: 16),
                          //!Password
                          CustomInputField(
                            labelText: 'Password',
                            hintText: 'Your password',
                            obscureText: true,
                            suffixIcon: true,
                            controller: context
                                .read<OngoingProjectCubit>()
                                .signInPassword,
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
                                    context
                                        .read<OngoingProjectCubit>()
                                        .signIn();
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
