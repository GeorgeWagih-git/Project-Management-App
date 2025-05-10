import 'dart:convert';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static Future<void> saveUser(
      UserModel user, String token, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
    await prefs.setString('token', token);
    await prefs.setString('role', role);
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString == null) return null;

    final userJson = jsonDecode(userString);
    return UserModel.fromJson(userJson);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // أو prefs.remove('token') لحذف عنصر واحد
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
