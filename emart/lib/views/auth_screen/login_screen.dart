import 'dart:convert';
import 'package:emart/constant.dart';
import 'package:emart/views/auth_screen/signup_screen.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import '../../consts/consts.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/our_button.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<void> loginToBackend(String email, String password) async {
    const apiUrl = 'http://10.0.2.2:8000/user/auth/login/';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      String token = json['key'];
      var box = await Hive.openBox(tokenBox);
      box.put("token", token);
      await getUser(token);

      Get.snackbar(
        'Success',
        'Logged in successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(() => const Home());
    } else {
      if (response.statusCode == 400) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey("non_field_errors")) {
          String errorMessage = jsonResponse["non_field_errors"][0];
          if (errorMessage
              .contains("Unable to log in with provided credentials.")) {
            Get.snackbar(
              'Error',
              'Invalid email or password',
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              colorText: Colors.white,
            );
          }
        }
      } else {
        Get.snackbar(
          'Error',
          'Login failed',
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          colorText: Colors.white,
        );
      }
      print('Login failed');
      print(response.body);
    }
  }

  getUser(String token) async {
    var url = Uri.parse("http://10.0.2.2:8000/user/auth/user/");
    var response =
        await http.get(url, headers: {'Authorization': 'Token ${token}'});
    print(response.body);
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  "Login in to $appname"
                      .text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  15.heightBox,
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        5.heightBox,
                        ourButton(
                          color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () {
                            final email = emailController.text;
                            final password = passwordController.text;
                            loginToBackend(email, password);
                          },
                        ).box.width(context.screenWidth - 50).make(),
                        5.heightBox,
                        ourButton(
                          color: lightGrey,
                          title: signup,
                          textColor: redColor,
                          onPress: () {
                            Get.to(() => const SignupScreen());
                          },
                        ).box.width(context.screenWidth - 50).make(),
                        5.heightBox,
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(const EdgeInsets.all(16))
                        .width(context.screenWidth - 70)
                        .shadowSm
                        .make(),
                  )
                ],
              ),
            )));
  }
}
