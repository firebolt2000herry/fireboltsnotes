// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/pages/auth_page.dart';

class ProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Profile"), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${user?.displayName ?? 'User'}'),
            SizedBox(height: 20),
            Text('Email: ${user?.email ?? 'No email found'}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Sign out user
                FirebaseAuth.instance.signOut();
                AuthPage(); // Go back to previous screen (home page)
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}