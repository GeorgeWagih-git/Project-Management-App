class UserModel {
  final String id;
  final String fullName;
  final String userName;
  final String email;
  final String? phoneNumber;
  final String? bio;
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    this.phoneNumber,
    this.bio,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      bio: json['bio'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'imageUrl': imageUrl,
    };
  }
}
