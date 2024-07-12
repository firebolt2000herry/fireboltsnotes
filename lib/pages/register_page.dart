// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/button.dart'; // Assuming MyButton is imported from 'button.dart'
import 'package:login_app/components/squarelogo.dart';
import 'package:login_app/components/text_fields.dart';
import 'package:login_app/pages/auth_page.dart';
import 'package:login_app/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Passwords don't match"),
            );
          },
        );
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Email"),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Password"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40),
              Center(child: Icon(Icons.lock, size: 75)),
              SizedBox(height: 30),
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 60),
              TextFields(
                controller: emailController,
                hint: "Username",
                isObscured: false,
              ),
              SizedBox(height: 10),
              TextFields(
                controller: passwordController,
                hint: "Password",
                isObscured: true,
              ),
              SizedBox(height: 10),
              TextFields(
                controller: confirmPasswordController,
                hint: "Confirm Password",
                isObscured: true,
              ),
              SizedBox(height: 20),
              MyButton(
                text: "Sign Up",
                onTap: () => signUserUp(context),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Text("Or continue with"),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SquareLogo(
                      onTap: () {
                        AuthService().signInWithGoogle();
                      },
                      src: 'lib/images/google_logo.png',
                    ),
                  ),
                  SizedBox(width: 10),
                  Center(
                    child: SquareLogo(
                      onTap: () {},
                      src: 'lib/images/apple_logo.png',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Login now",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}