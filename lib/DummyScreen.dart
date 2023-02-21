import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/announcement_screen.dart';
import 'package:naseeb/pallete.dart';
import 'package:naseeb/widgets/gradient_button.dart';
import 'package:page_transition/page_transition.dart';
class DummyScreen extends StatelessWidget {
  DummyScreen({Key? key}) : super(key: key);
  String? ann_title;
  String? ann_content;
  DateTime? ann_date;
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
            Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Pallete.gradient1,
                      Pallete.gradient2,
                      Pallete.gradient3,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child:
                ElevatedButton(
                  onPressed: () async {
                    var dio = Dio();
                    try {
                      var response = await dio.get('https://property-guru-api.onrender.com/getannouncement');
                      ann_title = response.data['title'];
                      ann_content = response.data['announcement'];
                      ann_date = response.data['date'];
                    } catch (e) {
                      print(e);
                    }
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: AnnouncementScreen(title: ann_title, content: ann_content, date: ann_date)));


                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(395, 55),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Announcements",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                )
            ),


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
