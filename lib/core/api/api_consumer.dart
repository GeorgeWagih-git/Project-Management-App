abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryData,
    Map<String, String>? headers,
  });
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryData,
    bool isFormData = false,
    Map<String, String>? headers,
  });
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryData,
    bool isFormData = false,
  });
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryData,
    bool isFormData = false,
  });
}
