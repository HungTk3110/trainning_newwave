import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/authentication_with_firebase/authentication_with_email/regester_screen.dart';
import 'package:training_newwave/authentication_with_firebase/authentication_with_phone_number/login_screen.dart';
import 'package:training_newwave/configs/app_styles.dart';
import 'package:training_newwave/main.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint("onMessage:");
        log("onMessage: $message");
        final snackBar =
            SnackBar(content: Text(message.notification?.title ?? ""));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String email = '', pass = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextField(
                onChanged: (value) {
                  pass = value;
                },
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: pass);
                    await Future.delayed(const Duration(seconds: 1));
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeMyApp(),
                        ),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                child: const Text('LogIn'),
              ),
              Text(
                "If you do not already have an account?",
                style: AppTextStyles.blackS12Medium,
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegesterEmailScreen(),
                    ),
                  );
                },
                child: const Text('Regester'),
              ),
              Text(
                "or Login with phone number",
                style: AppTextStyles.blackS12Medium,
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPhoneScreen(),
                    ),
                  );
                },
                child: const Text('login with phone number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
