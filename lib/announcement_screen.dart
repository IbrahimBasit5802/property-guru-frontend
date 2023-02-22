import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:naseeb/pallete.dart';

class AnnouncementScreen extends StatefulWidget {
  String? title;
  String? content;
  String? date;
  AnnouncementScreen({super.key, required this.title, required this.content, required this.date});
  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    return


      MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home:
         Scaffold(
          body: RefreshIndicator(
              onRefresh: () async {
                setState(() async {
                  print("ok");
                  var dio = Dio();
                  try {
                    var response = await dio.get('https://property-guru-api.onrender.com/getannouncement');
                    widget.title = response.data['title'];
                    widget.content = response.data['announcement'];
                    widget.date = response.data['date'];
                  } catch (e) {
                    print(e);
                  }
                });
              },
              child: 
          ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/signin_balls.png'),
                    Center(
                      child: FlutterSlimyCard(
                        topCardHeight: 160,
                        bottomCardHeight: 120,
                        topCardWidget: topWidget(),
                        bottomCardWidget: bottomWidget(),
                        color: Pallete.gradient2,
                        slimeEnabled: true,
                      ),
                    )],

                )),
  ])
        ),
      ),
    );
  }

  Widget topWidget() {
    return Container(

      child: SafeArea(
        child: Column(
          children: [
//            Container(height: 75, child: Image(image: AssetImage('assets/images/illustration-3.png'))),
            SizedBox(
              height: 35,
            ),
            Text(
              widget.title.toString(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomWidget() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          Flexible(
              child: Text(
                widget.content.toString(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
        ],
      ),
    );
  }


}
