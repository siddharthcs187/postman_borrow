import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:postman/signinpage.dart';
import 'Lend/lend_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return LendScreen();
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something Went Wrong!'));
        } else {
          return const SignInPage();
        }
      },
    );
  }
}
