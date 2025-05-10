import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_states.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/endpoints.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final response = await api.post(
        Endpoint.signIn,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );
      final data = response.data;

      final userJson = data['user'];
      final token = data['token'];
      final role = data['role'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('role', role);
      await prefs.setString('user', jsonEncode(userJson));
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(errMessage: e.errModel.message));
    }
  }
}
