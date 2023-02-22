import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:naseeb/login_screen.dart';
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
                  child: RefreshIndicator(

                    onRefresh: () async {
                      setState(() async {

                      });
                    },
                    child:
                  Column(
                    children: [
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      ProfileMenu(
                        arrow: false,
                        text: "Name: " + widget.empName.toString(),
                        icon: "assets/icons/User.svg",
                        press: () => {},
                      ),
                      ProfileMenu(
                        arrow: false,
                        text: "Phone: " + widget.empPhone.toString(),
                        icon: "assets/icons/Phone.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        arrow: false,
                        text: "Emplyee ID: " + widget.empID.toString(),
                        icon: "assets/icons/employee-card-svgrepo-com.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        arrow: false,
                        text: "Position: " + widget.empType.toString(),
                        icon: "assets/icons/job-management-svgrepo-com.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        arrow: false,
                        text: "Salary: " + widget.empSalary.toString(),
                        icon: "assets/icons/Cash.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        arrow: false,
                        text: "Status: " + widget.subStatus.toString(),
                        icon: "assets/icons/Star Icon.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        arrow: true,
                        color: Colors.green,
                        text: "Confirm",
                        icon: "assets/icons/Success.svg",
                        press: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: DummyScreen()));
                        },

                      ),
                      ProfileMenu(
                        arrow: false,
                        color: Colors.red,
                        text: "Logout",
                        icon: "assets/icons/Log out.svg",
                        press: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: LoginScreen()));
                        },

                      ),
                    ],
                  ),
                )
            )
      ));


  }



}
