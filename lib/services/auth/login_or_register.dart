// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:messaging_app/pages/login_page.dart';
import 'package:messaging_app/pages/register_page.dart';

// Define a widget for handling the login or register pages
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

// Define the state for the LoginOrRegister widget
class _LoginOrRegisterState extends State<LoginOrRegister> {
  // A boolean variable to keep track of whether to show the login or register page
  bool showLoginPage = true;

  // A method to toggle between the two pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Return the appropriate page based on the value of showLoginPage
    if (showLoginPage) {
      // If showLoginPage is true, display the LoginPage
      return LoginPage(onTap: togglePages);
    } else {
      // If showLoginPage is false, display the RegisterPage
      return RegisterPage(onTap: togglePages);
    }
  }
}
