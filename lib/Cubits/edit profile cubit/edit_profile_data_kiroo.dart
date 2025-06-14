import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> updateUserOnServer(UserModel user) async {
  final url = Uri.parse(
      "https://frankly-refined-escargot.ngrok-free.app/api/User/Edit");
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final body = jsonEncode(user.toJson());
  print("PUT $url");
  print("Token: $token");
  print("Body: $body");

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: body,
  );

  print("Status Code: ${response.statusCode}");
  print("Response Body: ${response.body}");

  return response.statusCode == 200;
}
