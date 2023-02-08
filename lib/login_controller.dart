import 'package:get/get.dart';

class LoginController extends GetxController {
  bool _invalid = false;
  bool get invalid => _invalid;
  void setInvalid() {
    _invalid = true;
    update();
  }

  void setValid() {
    _invalid = false;
    update();
  }
}