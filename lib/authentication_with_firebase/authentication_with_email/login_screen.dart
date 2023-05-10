import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/authentication_with_firebase/authentication_with_email/register_screen.dart';
import 'package:training_newwave/authentication_with_firebase/authentication_with_phone_number/login_screen.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/main.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  bool isEmailError = false;
  bool isPasswordError = false;
  late TextEditingController emailController, passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    try {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          debugPrint("onMessage:");
          log("onMessage: $message");
          final snackBar =
              SnackBar(content: Text(message.notification?.title ?? ""));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login With Email",
                style: AppTextStyles.blackS22bold,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isEmailError == false ? Colors.grey : Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: emailController,
                  onChanged: (value) {
                    setState(() {
                      isEmailError = false;
                      isPasswordError = false;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                  ),
                ),
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isPasswordError == false ? Colors.grey : Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      isEmailError = false;
                      isPasswordError = false;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "PassWord",
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      await Future.delayed(
                        const Duration(seconds: 1),
                      );
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeMyApp(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      if (!EmailValidator.validate(emailController.text)) {
                        setState(() {
                          isEmailError = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email validate'),
                          ),
                        );
                      } else if (e.code == 'user-not-found') {
                        setState(() {
                          isEmailError = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No user found for that email.'),
                          ),
                        );
                      } else if (e.code == 'wrong-password') {
                        setState(() {
                          isPasswordError = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Wrong password provided for that user.'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('LogIn'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.blackS16Medium,
                  children: <TextSpan>[
                    const TextSpan(
                        text: "If you not already have a account?   "),
                    TextSpan(
                      text: "Register",
                      style: AppTextStyles.blueS16Medium,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterEmailScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.blackS16Medium,
                  children: <TextSpan>[
                    const TextSpan(text: "OR  "),
                    TextSpan(
                      text: "Login with phone number",
                      style: AppTextStyles.blueS16Medium,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPhoneScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
