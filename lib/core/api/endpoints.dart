class Endpoint {
  static String baseUrl = "https://frankly-refined-escargot.ngrok-free.app";
  static String signIn = "/api/User/Login";
  static String signUp = "/api/User/register";
  static String createProject = "/api/Project/CreateProject";
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  ////////////signin//////////////////
  static String email = "Email";
  static String password = "password";
  ///////////////////////////
  static String message = "message";
/////////////////////////////////////////
  static String token = "token";
  static String id = "id";
  //////////////////////////////
  static String name = "FullName";
  static String username = "UserName";
  static String phone = "PhoneNumber";
  static String signUpPassword = "Password";
  static String profilePic = "Image";
  static String bio = "Bio";
}
