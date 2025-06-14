import 'package:flutter_application_1/Cubits/edit%20profile%20cubit/edit_profile_data_state.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/endpoints.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileDataCubit extends Cubit<EditProfileDataState> {
  EditProfileDataCubit(this.api) : super(ProfileInitial());
  static EditProfileDataCubit get(context) => BlocProvider.of(context);
  final ApiConsumer api;
  XFile? profilePic;
  Future<void> uploadProfileImage({required XFile file}) async {
    print('the function Started');
    try {
      emit(ProfileImageUploading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final fileName = file.path.split('/').last;

      final formData = {
        'NewImage': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      };

      await api.put(
        '/api/User/ChangeProfilePic',
        data: formData,
        isFormData: true,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      emit(ProfileImageUploadSuccess());
    } catch (e) {
      print('upload error: $e');
      emit(ProfileImageError(errorMessage: e.toString()));
    }
  }

  Future<void> deleteProfileImage() async {
    emit(ProfileImageDeleting());

    try {
      final token = await AppPrefs.getToken();

      await api.put(
        Endpoint.deleteProfilePic,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      emit(ProfileImageDeleteSuccess());
    } catch (e) {
      emit(ProfileImageError(errorMessage: e.toString()));
    }
  }
}
