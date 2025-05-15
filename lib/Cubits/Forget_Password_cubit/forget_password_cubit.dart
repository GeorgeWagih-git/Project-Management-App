import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Forget_Password_cubit/forget_password_states.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit(this.api) : super(ForgetPasswordInitial());

  static ForgetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final ApiConsumer api;
  final TextEditingController forgetPasswordEmail = TextEditingController();
  final TextEditingController resetPasswordEmail = TextEditingController();
  final TextEditingController resetPasswordToken = TextEditingController();
  final TextEditingController resetPasswordNewPassword =
      TextEditingController();
  Future<void> sendResetCode(String email) async {
    emit(SendResetCodeLoading());

    try {
      await api.post('/api/User/ForgetPassword/$email');
      emit(SendResetCodeSuccess());
    } catch (e) {
      emit(SendResetCodeFailure(errMessage: e.toString()));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());

    try {
      await api.post('/api/User/ResetPassword', data: {
        "email": email,
        "token": token,
        "newPassword": newPassword,
      });

      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(errMessage: e.toString()));
    }
  }
}
