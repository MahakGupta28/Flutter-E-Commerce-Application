import 'package:http/http.dart' as http;

class AuthApi {
  static Future<void> logOut(String token) async {
    var url = Uri.parse("http://10.0.2.2:8000/user/auth/logout/");
    var response = await http.post(
      url,
      headers: {'Authorization': 'Token $token'},
    );
    print(response.body);
  }
}
