

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/DummyScreen.dart';
import 'package:naseeb/announcement_screen.dart';
import 'package:naseeb/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'pallete.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var password = prefs.getString('password');
  await Firebase.initializeApp();
  var response;
  runApp(const MyApp());
  // runApp(email == null? const MyApp():
  //     try {
  //   var dio = Dio();
  //     response = await dio.post(
  //     "https://property-guru-api.onrender.com/authenticate",
  //     data: {"empID": email.toString(), "password": password.toString()});
  //     print(response);
  //
  //
  //
  //
  //     } catch (e) {
  //   print(e);
  //
  // }
  // );
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
      home:  const LoginScreen(),
    );
  }
}
