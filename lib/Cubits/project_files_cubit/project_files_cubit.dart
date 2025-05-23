import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/Cubits/project_files_cubit/project_files_states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ProjectFilesCubit extends Cubit<ProjectFilesState> {
  final ApiConsumer api;
  bool fileExists = false;

  ProjectFilesCubit(this.api) : super(ProjectFilesInitial());

  static ProjectFilesCubit get(context) => BlocProvider.of(context);
  File? selectedFile;

  void setFile(File file) {
    selectedFile = file;
  }

  Future<void> uploadFile({
    required int projectId,
  }) async {
    emit(ProjectFileUploading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final fileName = selectedFile!.path.split('/').last;
      final formData = {
        'Document': await MultipartFile.fromFile(selectedFile!.path,
            filename: fileName),
      };

      await api.put(
        '/api/Project/CreateProjectDocument/$projectId',
        data: formData,
        isFormData: true,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      fileExists = true;
      emit(ProjectFileUploadSuccess());
    } catch (e) {
      emit(ProjectFileError(errorMessage: e.toString()));
    }
  }

  Future<void> deleteFile(int projectId) async {
    emit(ProjectFileDeleting());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await api.put(
        '/api/Project/DeleteProjectDocument/$projectId',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      fileExists = false;
      emit(ProjectFileDeleteSuccess());
    } catch (e) {
      emit(ProjectFileError(errorMessage: e.toString()));
    }
  }

  Future<void> openFile(int projectId) async {
    emit(ProjectFileOpening());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await api.get(
        '/api/Project/GetProjectDocument/$projectId',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final fileUrl = response.toString().trim();

      final downloadResponse = await Dio().get(
        fileUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final bytes = downloadResponse.data;

      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/project_$projectId.pdf';
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      await OpenFile.open(file.path);

      emit(ProjectFileOpenSuccess());
    } catch (e) {
      emit(ProjectFileError(errorMessage: e.toString()));
    }
  }

  Future<void> checkIfFileExists(int projectId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await api.get(
        '/api/Project/GetProjectDocument/$projectId',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final fileUrl = response.toString().trim();

      fileExists = fileUrl.isNotEmpty;
      emit(ProjectFileCheckSuccess());
    } catch (_) {
      fileExists = false;
      emit(ProjectFileCheckSuccess());
    }
  }
}
