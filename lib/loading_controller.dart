import 'package:get/get.dart';


class LoadingController extends GetxController {
  bool _isLoading = false;
  bool get invalid => _isLoading;
  void isLoading() {
    _isLoading = true;
    update();
  }

  void isNotLoading() {
    _isLoading = false;
    update();
  }
}

// another comment