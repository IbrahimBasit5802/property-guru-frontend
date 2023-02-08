import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '/constants.dart';
import './widgets/profile_list_item.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
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
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            'Nicolas Adams',
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            'nicolasadams@gmail.com',
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
    text: 'Privacy',
    ),
    ProfileListItem(
    icon: LineAwesomeIcons.history,
    text: 'Purchase History',
    ),
    ProfileListItem(
    icon: LineAwesomeIcons.question_circle,
    text: 'Help & Support',
    ),
    ProfileListItem(
    icon: LineAwesomeIcons.cog,
    text: 'Settings',
    ),
    ProfileListItem(
    icon: LineAwesomeIcons.user_plus,
    text: 'Invite a Friend',
    ),
    ProfileListItem(
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