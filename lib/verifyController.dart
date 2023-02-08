import 'package:get/get.dart';


class VerifyController extends GetxController {

  bool _verified = false;
  bool get verified => _verified;
  void verify() {
    _verified = true;
    update();
  }

  void unverify() {
    _verified = false;
    update();
  }

}