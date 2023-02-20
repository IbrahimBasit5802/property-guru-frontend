import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'Invalid.dart';
import 'otp_screen.dart';

class MyPhone extends StatefulWidget {

  String? empID;
  String? empPassword;
  static String verify = "";

  MyPhone({super.key, required this.empID, required this.empPassword});

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  late ProgressDialog progressDialog;
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  InvalidController controller2 = Get.put(InvalidController());
  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+92";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      print("Phone Screen ID Value: " + widget.empID.toString());
                      print("Phone Screen Password Value: " + widget.empPassword.toString());
                      print("Phone Screen Phone Value: " + countryController.text.toString() + phoneController.text.toString());
                      showProgress(context, "Sending Code", false);
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countryController.text.toString() + phoneController.text.toString(),
                          verificationCompleted: (PhoneAuthCredential credential) {

                          },
                          verificationFailed: (FirebaseAuthException e) {
                            print(e.message);
                          },
                          codeSent: (String verificationID, int? resendToken) {
                          MyPhone.verify = verificationID;
                          hideProgress();

                          Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeftWithFade,
                                    child: Otp(empID: widget.empID, empPassword: widget.empPassword, empPhone: countryController.text.toString() + phoneController.text.toString())));
                          },
                          codeAutoRetrievalTimeout: (String verificationID) {

                          }
                      );


                    },
                    child: Text("Send the code")),
              )
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
}