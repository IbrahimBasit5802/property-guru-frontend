import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '/constants.dart';
import './widgets/profile_list_item.dart';
class HomePage extends StatefulWidget {

  String? token;
  String? subStatus;
  String? empID;
  String? empName;
  String? empType;
  String? empPhone;
  HomePage({super.key, required this.token, required this.subStatus, required this.empID, required this.empName, required this.empType, required this.empPhone});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(414, 896));
    print("Token: ${widget.token}");
  //print(subStatus);
    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[

                Align(
                  alignment: Alignment.bottomRight,

                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: kDarkPrimaryColor,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                      ),
                    ),

                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            widget.empName.toString(),
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            widget.empPhone.toString(),
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Text(
                'Subscribe',
                style: kButtonTextStyle,
              ),
            ),
          ),
           const SizedBox(height: 20),
        ],
      ),
    );



    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        Icon(
          LineAwesomeIcons.arrow_left,
          size: ScreenUtil().setSp(kSpacingUnit.w * 3),
        ),
        profileInfo,

        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );
    return ThemeProvider(initTheme: kDarkTheme,child: Builder(builder: (context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,

          home:   ThemeSwitchingArea(
            child: Builder(
              builder: (context) {
                return Scaffold(
                  body: Column(
                    children: <Widget>[
                      SizedBox(height: kSpacingUnit.w * 5),
                      header,
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            ProfileListItem(
                              icon: LineAwesomeIcons.user_shield,
                              text: widget.empID.toString(),
                            ),
                            ProfileListItem(
                              icon: LineAwesomeIcons.history,
                              text: widget.subStatus.toString(),
                            ),
                            ProfileListItem(
                              icon: LineAwesomeIcons.question_circle,
                              text: widget.empType.toString(),
                            ),

                            const ProfileListItem(
                              icon: LineAwesomeIcons.alternate_sign_out,
                              text: 'Logout',
                              hasNavigation: false,

                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
      );}),);

  }
}
