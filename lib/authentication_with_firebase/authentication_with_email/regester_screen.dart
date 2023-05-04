import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/authentication_with_firebase/authentication_with_email/login_screen.dart';

class RegesterEmailScreen extends StatelessWidget {
  final bool _validateEmail = false;
  final bool _validatePassWord = false;

  const RegesterEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = '', pass = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                decoration: InputDecoration(
                  hintText: 'Email',
                  errorText: _validateEmail ? 'Value Can\'t Be Empty' : null,
                ),
              ),
              TextField(
                onChanged: (value) {
                  pass = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  errorText: _validatePassWord ? 'Value Can\'t Be Empty' : null,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                              email: email, password: pass);
                      await Future.delayed(const Duration(seconds: 1));
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginEmailScreen(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        debugPrint('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        debugPrint(
                            'The account already exists for that email.');
                      }
                    } catch (e) {
                      debugPrint(
                        e.toString(),
                      );
                    }
                  },
                  child: const Text('Regester')),
            ],
          ),
        ),
      ),
    );
  }
}
