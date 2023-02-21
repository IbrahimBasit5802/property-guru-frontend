import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: Scaffold(
        body: Center(
            child: ExpansionCard(
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title.toString(),
                    ),
                    Text(
                      widget.date.toString(),
                    ),

                  ],
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Text(widget.content.toString()),
                  ),

              ],
            ))
      ),
    );
  }


}
