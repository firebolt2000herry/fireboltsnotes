// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/pages/homepage.dart';
import 'package:login_app/pages/login_or_register.dart';
import 'package:login_app/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return HomePage();
          } else if (!snapshot.hasData){
            return LoginOrRegister();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}