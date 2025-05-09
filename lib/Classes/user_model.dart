import 'package:flutter_application_1/core/api/endpoints.dart';

class UserModel {
  final String name;
  final String userName;
  final String bio;
  final String id;
  final String profilePic;
  final String email;
  final String phone;

  UserModel({
    required this.profilePic,
    required this.bio,
    required this.id,
    required this.userName,
    required this.email,
    required this.phone,
    required this.name,
  });
  factory UserModel.formJson(Map<String, dynamic> jsonData) {
    return UserModel(
      profilePic: jsonData[ApiKey.profilePic] ?? 'error',
      email: jsonData[ApiKey.email] ?? 'error to get Email',
      phone: jsonData[ApiKey.phone] ?? 'error to get phoneNumber',
      name: jsonData[ApiKey.name] ?? 'error to get Name',
      bio: jsonData[ApiKey.bio] ?? 'error to get bio',
      id: jsonData[ApiKey.id] ?? 'error to get id',
      userName: jsonData[ApiKey.username] ?? 'error to get user name',
    );
  }
}
