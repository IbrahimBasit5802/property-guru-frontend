import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:naseeb/home_page.dart';
import 'package:naseeb/login_screen.dart';
import 'package:naseeb/pallete.dart';
import 'package:naseeb/register_screen.dart';
import 'package:naseeb/verifyController.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'Invalid.dart';
import 'addPhoneNumber_screen.dart';

class Otp extends StatefulWidget {
  String? empID;
  String? empPassword;
  String? empPhone;
  Otp({super.key, required this.empID, required this.empPassword, required this.empPhone});
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late ProgressDialog progressDialog;
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();
  VerifyController controller = Get.put(VerifyController());
  InvalidController controller2 = Get.put(InvalidController());
  @override
  Widget build(BuildContext context) {
    print("OTP Screen ID Vallue: " +  widget.empID.toString());
    print("OTP Screen Password Vallue: " +  widget.empPassword.toString());
    print("OTP Screen Phone Vallue: " +  widget.empPhone.toString());
    var size = MediaQuery.of(context).size;
  return Scaffold(
        backgroundColor: Pallete.backgroundColor,
        resizeToAvoidBottomInset: false,

        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Image.asset('assets/images/signin_balls.png'),

                SizedBox(
                  height: 18,
                ),

                SizedBox(
                  height: 24,
                ),
                Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,

                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  width: size.width * 0.9,
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Pallete.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textFieldOTP(first: true, last: false, controller: _controller),
                          _textFieldOTP(first: false, last: false, controller: _controller2),
                          _textFieldOTP(first: false, last: false, controller: _controller3),
                          _textFieldOTP(first: false, last: false, controller: _controller4),
                          _textFieldOTP(first: false, last: false, controller: _controller5),
                          _textFieldOTP(first: false, last: true, controller: _controller6),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      GetBuilder<InvalidController>(
                        builder: (invalidController) {


                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {

                              try {
                                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                                    verificationId: MyPhone.verify,
                                    smsCode: _controller.text + _controller2.text + _controller3.text + _controller4.text + _controller5.text + _controller6.text
                                );
                                await auth.signInWithCredential(credential);
                              }
                              catch(e) {
                                print(e);
                              }

                              showProgress(context, "Signing Up...", false);
                              var dio = Dio();
                              String? userName;
                              var response;
                              String? msg;
                              final String id = widget.empID.toString();
                              print("password: " + widget.empPassword.toString());
                              try {
                                response = await dio.post(
                                    "https://property-guru-api.onrender.com/adduser",
                                    data: {"empID": widget.empID, "phone": widget.empPhone, "password": widget.empPassword});
                                print(response);



                                userName = response.data['empName'];
                              } catch (e) {
                                print(e);
                                print("nasa");
                              }

                              hideProgress();

                              if (response.data['success'] == false) {
                                controller2.setInvalid();
                                msg = response.data['msg'];
                              }

                              else if(response.data['success'] == true){
                                controller2.setValid();
                                msg = response['msg'];
                              }

                              showProgress(context, "Logging in...", false);

                              try {
                                response = await dio.post(
                                    "https://property-guru-api.onrender.com/authenticate",
                                    data: {"empID": widget.empID, "password": widget.empPassword});
                                print(response);




                              } catch (e) {
                                print(e);

                              }

                              String? tok;
                              tok = response.data['token'];
                              String? subStatus;
                              String? name;
                              String? ID;
                              String? phone;
                              String? role;
                              String? salary;
                              try {
                                response = await dio.get('https://property-guru-api.onrender.com/getinfo', options: Options(
                                    headers: {
                                      "Authorization": "Bearer $tok"
                                    }


                                ));
                                print(response);
                                subStatus = response.data['subscriptionStatus'].toString();
                                name = response.data['name'].toString();
                                ID = response.data['empID'].toString();
                                phone = response.data['phone'].toString();
                                role = response.data['userType'].toString();
                                salary = response.data['salary'].toString();
                                print("Sub : $subStatus");
                              } catch (e) {
                                print(e);
                              }

                              hideProgress();

                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeftWithFade,
                                      child: HomePage(token: tok, subStatus: subStatus, empID: ID, empName: name, empType: role, empPhone: phone, empSalary: salary)));
                            },
                            style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<Color>(Pallete.backgroundColor),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Verify',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                        }
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Didn't receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,

                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );

  }

  Widget field({required bool autoFocus, controller}) {
   return SizedBox(
    height: 60,
    width: 50,
    child: TextField(
      autofocus: autoFocus,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      controller: controller,
      maxLength: 1,
      cursorColor: Theme.of(context).primaryColor,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
          hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
    ),
  );
  }


  Widget _textFieldOTP({required bool first, last, controller}) {

    return Expanded(
      child: Container(
        height: 85,
       // width: MediaQuery.of(context).size.width * 0.1,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: TextField(
            autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.length == 0 && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
            keyboardType: TextInputType.number,
            controller: controller,
            maxLength: 1,
            decoration: InputDecoration(
              counter: Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.purple),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ),
    );
  }

  _showConfirmationDialog(BuildContext context, userName) {
    VerifyController controller = Get.put(VerifyController());
    InvalidController controller2 = Get.put(InvalidController());
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
                controller2.setInvalid();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _showConfirmationDialogSignUp(BuildContext context, msg) {
    VerifyController controller = Get.put(VerifyController());
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Congratulations'),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () async {

                controller.unverify();

                Navigator.pop(context);

                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: const LoginScreen()));

              },
            ),


          ],
        );
      },
    );
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
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: const RegisterScreen()));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
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