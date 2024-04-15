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
    // The app will return a component that will check the status of the user
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}