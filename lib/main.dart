

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/DummyScreen.dart';
import 'package:naseeb/otp_screen.dart';

import 'login_screen.dart';
import 'pallete.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Property Guru',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: const LoginScreen(),
    );
  }
}
