import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/authentication_with_firebase/authentication_with_email/login_screen.dart';
import 'package:training_newwave/configs/app_styles.dart';

class RegisterEmailScreen extends StatefulWidget {
  const RegisterEmailScreen({Key? key}) : super(key: key);

  @override
  State<RegisterEmailScreen> createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  bool isEmailError = false;
  bool isPasswordError = false;
  late TextEditingController emailController, passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register Uer",
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
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
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
                            builder: (context) => const LoginEmailScreen(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        setState(() {
                          isPasswordError = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('The password provided is too weak.'),
                          ),
                        );
                      } else if (!EmailValidator.validate(
                          emailController.text)) {
                        setState(() {
                          isEmailError = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email invalidate'),
                          ),
                        );
                      } else if (e.code == 'email-already-in-use') {
                        setState(() {
                          isEmailError = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'The account already exists for that email.'),
                          ),
                        );
                      }
                    } catch (e) {
                      debugPrint(
                        e.toString(),
                      );
                    }
                  },
                  child: const Text('Register'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.blackS16Medium,
                  children: <TextSpan>[
                    const TextSpan(text: "Do you already have an account?   "),
                    TextSpan(
                      text: "Login",
                      style: AppTextStyles.blueS16Medium,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
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
