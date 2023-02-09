import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:naseeb/home_page.dart';
import 'package:naseeb/verifyController.dart';
import 'package:page_transition/page_transition.dart';
import 'loading_controller.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '/widgets/gradient_button.dart';
import '/widgets/login_field.dart';
import 'Invalid.dart';
import 'login_controller.dart';
import 'pallete.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    TextEditingController empIDController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    LoginController controller2 = Get.put(LoginController());
    LoadingController loadingController = Get.put(LoadingController());

    loadingController.isNotLoading();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/signin_balls.png'),
                const Text(
                  'Sign in.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 50),
                const SizedBox(height: 20),
                const SizedBox(height: 15),
                const SizedBox(height: 15),
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
                    child: GetBuilder<LoginController>(
                        builder: (loginController) {
                          return ElevatedButton(
                            onPressed: () async {
                              showProgress(context, 'Logging In', false);

                              var dio = Dio();

                              var response;
                              String? msg;


                              if (empIDController.text == null) {
                                empIDController.text = "";
                              }
                              if (passwordController.text == null) {
                                passwordController.text = "";
                              }
                              loadingController.isLoading();
                              try {
                                response = await dio.post(
                                    "https://property-guru-api.onrender.com/authenticate",
                                    data: {"empID": empIDController.text.toString(), "password": passwordController.text.toString()});
                                print(response);




                              } catch (e) {
                                print(e);

                              }
                              hideProgress();
                              loadingController.isNotLoading();

                              String? token;

                              if (response.data['success'] == false) {
                                print ("lmao");
                                controller2.setInvalid();
                                msg = response.data['msg'];
                              }

                              else if(response.data['success'] == true){
                                controller2.setValid();
                                msg = response.data['msg'];
                              }

                              token = response.data['token'];

                              !controller2.invalid
                                  ? _showConfirmationDialog(
                                  context, msg, token)
                                  : _showErrorDialog(context, msg);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(395, 55),
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          );
                        })),
                const SizedBox(height: 40),
                GradientButton(ButtonText: "Register", employeeID: "",),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showConfirmationDialog(BuildContext context, msg, tok) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logged in Successfully'),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),

              onPressed: () async {
                String? subStatus;

                String? name;
                String? phoneNum;
                String? empID;
                String? role;
                String? salary;

                var response;

                var dio = Dio();



                  try {
                    response = await dio.get('https://property-guru-api.onrender.com/getinfo', options: Options(
                        headers: {
                          "Authorization": "Bearer $tok"
                        }


                    ));
                    print(response);
                    subStatus = response.data['subscriptionStatus'].toString();
                    name = response.data['name'].toString();
                    empID = response.data['empID'].toString();
                    phoneNum = response.data['phone'].toString();
                    role = response.data['userType'].toString();
                    salary = response.data['salary'].toString();
                    print("Sub : $subStatus");
                  } catch (e) {
                    print(e);
                  }


                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:  HomePage(token: tok, subStatus: subStatus, empName: name, empPhone: phoneNum, empID: empID, empType: role, empSalary: salary,)));

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
