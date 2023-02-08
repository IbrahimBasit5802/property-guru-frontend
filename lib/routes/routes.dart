import 'package:get/get.dart';
import '/login_screen.dart';
import '/register_screen.dart';

class RoutesClass {
  static String home = "/LoginScreen";
  static String registerScreen = "/RegisterScreen";

  static String getHomeRoute() => home;
  static String getRegisterScreenRoute() => registerScreen;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const LoginScreen()),
    GetPage(
        name: registerScreen,
        page: () => const RegisterScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
  ];
}
