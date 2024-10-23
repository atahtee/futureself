import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futureme/auth/auth_gate.dart';
import 'package:futureme/firebase_options.dart';
import 'package:futureme/notifications/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => FirebaseApi().initNotifications(context));

    return MaterialApp(
      title: 'Futureself',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}
