import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:naseeb/announcement_screen.dart';
import 'package:naseeb/pallete.dart';
import 'package:naseeb/widgets/gradient_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
class DummyScreen extends StatefulWidget {

  DummyScreen({Key? key}) : super(key: key);

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  String? ann_title;

  String? ann_content;

  String? ann_date;
  late ProgressDialog progressDialog;
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
                    showProgress(context, "Fetching Announcements...", false);
                    var dio = Dio();
                    try {
                      var response = await dio.get('https://property-guru-api.onrender.com/getannouncement');
                      ann_title = response.data['title'];
                      ann_content = response.data['announcement'];
                      ann_date = response.data['date'];
                    } catch (e) {
                      print(e);
                    }
                    hideProgress();
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
              GradientButton(ButtonText: "Subscription"),
              const SizedBox(height: 20,),
              GradientButton(ButtonText: "History"),
              const SizedBox(height: 20,),
              GradientButton(ButtonText: "Dummy Button"),
            ],
          ),
        ),
      ),
    );
  }

  showProgress(BuildContext context, String message, bool isDismissible) async {
    progressDialog = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: isDismissible);
    progressDialog.style(
        message: message,
        borderRadius: 10.0,
        backgroundColor: Colors.black,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            )),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600));
    await progressDialog.show();
  }

  updateProgress(String message) {
    progressDialog.update(message: message);
  }

  hideProgress() async {
    if(progressDialog!=null)
      await progressDialog.hide();
  }
}
