import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/Sign_Up_cubit/sign_up_states.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/endpoints.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit(this.api) : super(SignUpInitialState());
  static SignUpCubit get(BuildContext context) => BlocProvider.of(context);
  final ApiConsumer api;
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  void uploadProfilePic(XFile pickedFile) {
    profilePic = pickedFile;
    emit(OngoingProjectImageSelected());
  }

  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up username
  TextEditingController signUpUserName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  // sign up bio
  TextEditingController bio = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  signUp() async {
    try {
      emit(SignUpLoading());
      final imageFile = profilePic;
      final fileName =
          imageFile != null ? imageFile.path.split('/').last : null;
      await api.post(
        Endpoint.signUp,
        isFormData: true,
        data: {
          ApiKey.name: signUpName.text,
          ApiKey.username: signUpUserName.text,
          ApiKey.email: signUpEmail.text,
          ApiKey.phone: signUpPhoneNumber.text,
          ApiKey.signUpPassword: signUpPassword.text,
          ApiKey.bio: bio.text,
          // ApiKey.profilePic: await uploadImageToApi(profilePic!),
          if (imageFile != null)
            ApiKey.profilePic: await MultipartFile.fromFile(
              imageFile.path,
              filename: fileName,
            ),
        },
      );
      emit(SignUpSuccess());
    } on ServerException catch (e) {
      emit(SignUpFailure(errMessage: e.errModel.message));
    }
  }
}
