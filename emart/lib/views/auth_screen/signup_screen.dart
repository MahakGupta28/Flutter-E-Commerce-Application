import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../widgets_common/our_button.dart';
import '../../consts/consts.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../home_screen/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  bool isCheck = false;

  Future<void> registerUser(
    String email,
    String password1,
    String password2,
  ) async {
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter the email',
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        colorText: Colors.white,
      );
      return;
    }

    bool isValidEmail(String email) {
      return email.contains('@') && email.endsWith('gmail.com');
    }

    if (!isValidEmail(email)) {
      Get.snackbar(
        'Error',
        'Invalid email format',
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        colorText: Colors.white,
      );
      return;
    }

    if (password1.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter the password',
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        colorText: Colors.white,
      );
      return;
    }

    if (password2.isEmpty) {
      Get.snackbar(
        'Error',
        'Please confirm the password',
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        colorText: Colors.white,
      );
      return;
    }

    if (password1 != password2) {
      Get.snackbar(
        'Error',
        'Password does not match',
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        colorText: Colors.white,
      );
      return;
    }

    Map<String, String> data = {
      "email": email,
      "password1": password1,
      "password2": password2,
    };

    var url = Uri.parse("http://10.0.2.2:8000/user/auth/registration/");
    var response = await http.post(url, body: data);

    if (response.statusCode == 200 || response.statusCode == 204) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json.containsKey("key")) {
          String token = json["key"];
          print('User registered successfully');
          Get.snackbar(
            'Success',
            'Signup successfully',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.to(() => const Home());
        }
      } else {
        print('User registered successfully');
        Get.snackbar(
          'Success',
          'Registered successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(() => const Home());
      }
    } else {
      if (response.statusCode == 400) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey("password1")) {
          List<dynamic> passwordErrors = jsonResponse["password1"];
          if (passwordErrors.contains("This password is too short.")) {
            Get.snackbar(
              'Error',
              'Password is too short',
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              colorText: Colors.white,
            );
          } else if (passwordErrors.contains("This password is too common.")) {
            Get.snackbar(
              'Error',
              'Password is too common',
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              colorText: Colors.white,
            );
          }
        } else {
          Get.snackbar(
            'Error',
            'Registration failed',
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            colorText: Colors.white,
          );
          print('User registration failed');
          print(response.body);
          print(response.statusCode);
        }
      } else {
        Get.snackbar(
          'Error',
          'Registration failed',
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          colorText: Colors.white,
        );
        print('User registration failed');
        print(response.body);
        print(response.statusCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: password1Controller,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  TextFormField(
                    controller: password2Controller,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: redColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue!;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to the",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: termAndconditins,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                ),
                              ),
                              TextSpan(
                                text: "&",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.heightBox,
                  ourButton(
                    color: isCheck ? redColor : lightGrey,
                    title: signup,
                    textColor: whiteColor,
                    onPress: () {
                      final email = emailController.text;
                      final password1 = password1Controller.text;
                      final password2 = password2Controller.text;
                      registerUser(email, password1, password2);
                    },
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: alredyHaveAccount,
                          style: TextStyle(fontFamily: bold, color: fontGrey),
                        ),
                        TextSpan(
                          text: login,
                          style: TextStyle(fontFamily: bold, color: redColor),
                        ),
                      ],
                    ),
                  ).onTap(() {
                    Get.back();
                  }),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
