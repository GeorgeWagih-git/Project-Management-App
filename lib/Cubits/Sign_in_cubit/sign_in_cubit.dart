import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_states.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/endpoints.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit(this.api) : super(SignInInitialState());
  static SignInCubit get(BuildContext context) => BlocProvider.of(context);
  final ApiConsumer api;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  final TextEditingController signInEmail = TextEditingController();
  //Sign in password
  final TextEditingController signInPassword = TextEditingController();
  signIn() async {
    try {
      emit(SignInLoading());
      await api.post(
        Endpoint.signIn,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(errMessage: e.errModel.message));
    }
  }
}
