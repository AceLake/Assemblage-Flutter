// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/firebase_options.dart';
import 'package:messaging_app/services/auth/auth_gate.dart';
import 'package:messaging_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'services/auth/login_or_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      // This is used for state management
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

// The widget that will be called when the main is ran
class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Background color
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
        ),
      ),
    ),
    home: AuthGate(),
  );
}

}