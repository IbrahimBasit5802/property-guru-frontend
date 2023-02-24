import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:naseeb/login_screen.dart';
import 'package:naseeb/pallete.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'announcement_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> initializeFirebaseServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // FirebaseMessaging.instance.getToken().then((value) {
  //   print("Token: $value");
  // });
  // // If app is running in background, it works
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   print('onMessageOpened: $message');
  //   Navigator.push(
  //       navigatorKey.currentState!.context,
  //       PageTransition(
  //           type: PageTransitionType.rightToLeft,
  //           child:  AnnouncementScreen(title: message.data['title'], content: message.data['announcement'], date: message.data['date'],)));
  //
  // });
  // // Works even if app is closed
  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   if (message != null) {
  //     Navigator.push(
  //         navigatorKey.currentState!.context,
  //         PageTransition(
  //             type: PageTransitionType.rightToLeft,
  //             child:  AnnouncementScreen(title: message.data['title'], content: message.data['announcement'], date: message.data['date'],)));
  //   }
  // });
  //
  // FirebaseMessaging.onBackgroundMessage(
  //   _firebaseMessagingBackgroundHandler,
  // );
  var response;
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message}');
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/icons/logo.png'),

        splashTransition: SplashTransition.slideTransition,
        backgroundColor: Pallete.backgroundColor,

        nextScreen: const LoginScreen(),
        function: initializeFirebaseServices,
      ),
    );
  }
}
