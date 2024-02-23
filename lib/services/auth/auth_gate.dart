import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/pages/landing_page.dart';
import 'package:messaging_app/pages/login_page.dart';
import 'package:messaging_app/services/auth/login_or_register.dart';

import '../../pages/find_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the user is logged in
        if (snapshot.hasData) {
          return LandingPage();
        } else {
          return const LoginOrRegister();
        }
        // if the user isn't logged in
      },
    ));
  }
}
