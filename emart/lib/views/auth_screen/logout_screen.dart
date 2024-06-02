import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  Future<void> logOut(String token) async {
    var url = Uri.parse("http://10.0.2.2:8000/user/auth/logout/");
    var response = await http.post(url, headers: {
      'Authorization': 'Token ${token}',
    });
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
