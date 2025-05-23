import 'dart:io';

abstract class ProjectFilesState {}

class ProjectFilesInitial extends ProjectFilesState {}

class ProjectFilePicked extends ProjectFilesState {
  final File file;
  ProjectFilePicked(this.file);
}

class ProjectFileUploading extends ProjectFilesState {}

class ProjectFileUploadSuccess extends ProjectFilesState {}

class ProjectFileError extends ProjectFilesState {
  final String errorMessage;
  ProjectFileError({required this.errorMessage});
}

class ProjectFileDeleting extends ProjectFilesState {}

class ProjectFileDeleteSuccess extends ProjectFilesState {}

class ProjectFileOpenSuccess extends ProjectFilesState {}

class ProjectFileOpening extends ProjectFilesState {}
