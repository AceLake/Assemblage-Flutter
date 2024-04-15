// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:messaging_app/components/my_button.dart';
import 'package:messaging_app/components/my_text_field.dart';
import 'package:messaging_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    // Access the AuthService using the Provider
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      // Call the signInWithEmailAndPassword method from the AuthService
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      // Display an error message if sign-in fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 253),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Assemblage',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 15),

              // Welcome back message
              const Text(
                "Hello and welcome back",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 25),

              // Email input
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              SizedBox(height: 15),

              // Password input
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              SizedBox(height: 15),

              // Sign In button
              MyButton(onTap: signIn, text: "Login"),

              SizedBox(height: 50),

              // Register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Register now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ]),
          ),
        ),
      ),
    );
  }
}
