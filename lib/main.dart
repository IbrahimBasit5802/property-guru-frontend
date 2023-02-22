

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/DummyScreen.dart';
import 'package:naseeb/announcement_screen.dart';
import 'package:naseeb/otp_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'pallete.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var password = prefs.getString('password');
  await Firebase.initializeApp();
  FirebaseMessaging.instance.getToken().then((value) {
    print("Token: $value");
  });
  // If app is running in background, it works
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print('onMessageOpened: $message');
    Navigator.push(
        navigatorKey.currentState!.context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child:  AnnouncementScreen(title: message.data['title'], content: message.data['announcement'], date: message.data['date'],)));

  });
  // Works even if app is closed
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      Navigator.push(
          navigatorKey.currentState!.context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child:  AnnouncementScreen(title: message.data['title'], content: message.data['announcement'], date: message.data['date'],)));
    }
  });
  
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message}');
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
