import 'package:flutter_application_1/core/api/endpoints.dart';

class ErrorModel {
  final String message;

  ErrorModel({required this.message});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    print('⚠️ ErrorModel received this json: $jsonData');

    final dynamic messageValue = jsonData[ApiKey.message];

    return ErrorModel(
      message: messageValue?.toString() ?? 'Unexpected error',
    );
  }
}
