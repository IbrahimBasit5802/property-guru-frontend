import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:naseeb/login_screen.dart';

import 'package:naseeb/verifyController.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '/widgets/gradient_button.dart';

import 'Invalid.dart';
import 'pallete.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late ProgressDialog progressDialog;
  @override
  Widget build(BuildContext context) {
    TextEditingController empIDController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    VerifyController controller = Get.put(VerifyController());
    InvalidController controller2 = Get.put(InvalidController());

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
            child: GetBuilder<VerifyController>(builder: (verifyController) {
          return Center(
              child: controller.verified
                  ? Column(
                      children: [
                        Image.asset('assets/images/signin_balls.png'),
                        const Text(
                          'Sign Up.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(height: 40),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: TextFormField(
                            controller: empIDController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(27),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Pallete.borderColor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Pallete.gradient2,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Employee ID",
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: TextFormField(
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(27),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Pallete.borderColor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Pallete.gradient2,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Phone Number",
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(27),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Pallete.borderColor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Pallete.gradient2,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Password",
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),



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
                  child: GetBuilder<InvalidController>(
                      builder: (invalidController) {
                        return ElevatedButton(
                          onPressed: () async {
                            showProgress(context, "Signing Up...", false);
                            var dio = Dio();
                            String? userName;
                            var response;
                            String? msg;
                            final String id = empIDController.text;
                            print(id);
                            try {
                              response = await dio.post(
                                  "https://property-guru-api.onrender.com/adduser",
                                  data: {"empID": empIDController.text.toString(), "phone": phoneNumberController.text.toString(), "password": passwordController.text.toString()});
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
                              msg = response.data['msg'];
                            }

                            !controller2.invalid
                                ? _showConfirmationDialogSignUp(
                                context, msg)
                                : _showErrorDialog(context, msg);
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(395, 55),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        );
                      })),





                        const SizedBox(height: 30),
                        GradientButton(ButtonText: "Login Instead"),
                      ],
                    )
                  // else
                  : Column(
                      children: [
                        Image.asset('assets/images/signin_balls.png'),
                        const Text(
                          'Sign Up.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(height: 40),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: TextFormField(
                            controller: empIDController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(27),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Pallete.borderColor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Pallete.gradient2,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Employee ID",
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
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
                            child: GetBuilder<InvalidController>(
                                builder: (invalidController) {
                              return ElevatedButton(
                                onPressed: () async {
                                  showProgress(context, "Verifying your employee id, please wait", false);
                                  var dio = Dio();
                                  var userName = "";
                                  var response;
                                  var msg = "";

                                  try {
                                    response = await dio.post(
                                        "https://property-guru-api.onrender.com/verifyemp",
                                        data: {"empID": empIDController.text.toString()});
                                    print(response);




                                  } catch (e) {
                                    print(e);

                                  }

                                  hideProgress();

                                  if (response.data['success'] == false) {
                                    controller2.setInvalid();
                                    msg = response.data['msg'];
                                  }

                                  else if(response.data['success'] == true){
                                    controller2.setValid();
                                    userName = response.data['empName'];
                                  }


                                  !controller2.invalid
                                      ? _showConfirmationDialog(
                                          context, userName)
                                      : _showErrorDialog(context, msg);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(395, 55),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: const Text(
                                  "Verify",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                              );
                            })),
                        const SizedBox(height: 30),
                        GradientButton(
                          ButtonText: "Login Instead",
                          employeeID: "",

                        ),
                      ],
                    ));
        })),
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
              onPressed: () {
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
