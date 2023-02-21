import 'package:flutter/material.dart';
import 'package:naseeb/pallete.dart';
import 'package:naseeb/widgets/gradient_button.dart';
class DummyScreen extends StatelessWidget {
  const DummyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Notice Board.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 100,),
              GradientButton(ButtonText: "Announcements"),
              const SizedBox(height: 20,),
              GradientButton(ButtonText: "Dummy Button"),
              const SizedBox(height: 20,),
              GradientButton(ButtonText: "Dummy Button"),
              const SizedBox(height: 20,),
              GradientButton(ButtonText: "Dummy Button"),
            ],
          ),
        ),
      ),
    );
  }
}
