import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:naseeb/Invalid.dart';
import '/login_screen.dart';
import '/pallete.dart';
import '/register_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/quickalert.dart';
import 'package:naseeb/verifyController.dart';
import 'package:dio/dio.dart';

class GradientButton extends StatefulWidget {
  String ButtonText;
  String employeeID;
  GradientButton({required this.ButtonText, this.employeeID = ""});

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    VerifyController controller = Get.put(VerifyController());
    InvalidController controller2 = Get.put(InvalidController());
    return Container(
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
        child: GetBuilder<InvalidController>(builder: (invalidController) {
          return ElevatedButton(
            onPressed: () async {
              if (widget.ButtonText == "Register") {
                controller2.setValid();
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: const RegisterScreen()));
              } else if (widget.ButtonText == "Login Instead") {
                controller.unverify();
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const LoginScreen()));
              } else if (widget.ButtonText == "Verify") {
                var dio = Dio();
                var userName;
                var response;
                var msg;
                print("Hey: " + widget.employeeID);
                try {
                  response = await dio.post("http://localhost:3000/verifyemp",
                      data: {widget.employeeID});

                  print(response);
                  userName = response.data['empName'];
                  print("Hey: " + widget.employeeID);
                } catch (e) {
                  print(e);
                }

                if (response.data['success'] == false) {
                  controller2.setInvalid();
                  msg = response.data['msg'];
                }

                !controller2.invalid
                    ? _showConfirmationDialog(context, userName)
                    : _showErrorDialog(context, msg);
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(395, 55),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              widget.ButtonText,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          );
        }));
  }

  _showErrorDialog(BuildContext context, msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  _showConfirmationDialog(BuildContext context, userName) {
    VerifyController controller = Get.put(VerifyController());
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Are you $userName?'),
          actions: <Widget>[
            ElevatedButton(

              child: Text('Yes'),
              onPressed: () {
                Navigator.pop(context);
                controller.verify();
              },
            ),
            ElevatedButton(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
