abstract class EditProfileDataState {}

class ProfileInitial extends EditProfileDataState {}

class ProfileImageUploading extends EditProfileDataState {}

class ProfileImageUploadSuccess extends EditProfileDataState {}

class ProfileImageDeleting extends EditProfileDataState {}

class ProfileImageDeleteSuccess extends EditProfileDataState {}

class ProfileImageError extends EditProfileDataState {
  final String errorMessage;

  ProfileImageError({required this.errorMessage});
}
