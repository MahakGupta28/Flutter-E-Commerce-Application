import 'package:emart/views/auth_screen/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:emart/widgets_common/applogo_widget.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/views/auth_screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _handleLogout(BuildContext context, String token) async {
    await AuthApi.logOut(token);

    // Navigate back to the login screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighpurple,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Image.asset(icSplashBg, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                applogoWidget(),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appname,
                      style: TextStyle(
                        fontFamily: bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      appversion,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            const Text(
              credits,
              style: TextStyle(
                fontFamily: semibold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: "Logged out suceessfully".text.make()));
                const token = 'token';
                await _handleLogout(context, token);
              },
              style: ElevatedButton.styleFrom(
                primary: purple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
