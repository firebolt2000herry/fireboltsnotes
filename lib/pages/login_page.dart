// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/button.dart'; // Assuming MyButton is imported from 'button.dart'
import 'package:login_app/components/squarelogo.dart';
import 'package:login_app/components/text_fields.dart';
import 'package:login_app/pages/auth_page.dart';
import 'package:login_app/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
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
              Center(child: Icon(Icons.lock, size: 150)),
              SizedBox(height: 30),
              Text(
                "Welcome back you've been missed!",
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot Password?",
                        style: TextStyle(color: Colors.grey[600]))
                  ],
                ),
              ),
              SizedBox(height: 20),
              MyButton(
                text: "Sign In",
                onTap: () => signUserIn(context),
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
                  Text("Not a member?"),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Register now",
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