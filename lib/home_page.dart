import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '/constants.dart';
import './widgets/profile_list_item.dart';
import 'DummyScreen.dart';
import 'components/profile_menu.dart';
class HomePage extends StatefulWidget {

  String? token;
  String? subStatus;
  String? empID;
  String? empName;
  String? empType;
  String? empPhone;
  String? empSalary;
  HomePage({super.key, required this.token, required this.subStatus, required this.empID, required this.empName, required this.empType, required this.empPhone, required this.empSalary});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {

      return MaterialApp(
          debugShowCheckedModeBanner: false,

          home: Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [

                  SizedBox(height: 20),
                  ProfileMenu(
                    text: widget.empName.toString(),
                    icon: "assets/icons/User Icon.svg",
                    press: () => {},
                  ),
                  ProfileMenu(
                    text: widget.empPhone.toString(),
                    icon: "assets/icons/Bell.svg",
                    press: () {},
                  ),
                  ProfileMenu(
                    text: widget.empID.toString(),
                    icon: "assets/icons/Settings.svg",
                    press: () {},
                  ),
                  ProfileMenu(
                    text: widget.empType.toString(),
                    icon: "assets/icons/Question mark.svg",
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Confirm",
                    icon: "assets/icons/Log out.svg",
                    press: () {
                      Navigator.push(
                          context,
                          PageTransition(
                          type: PageTransitionType.fade,
                          child: DummyScreen()));
                    },
                  ),
                ],
              ),
            )
          ));

  }
}
