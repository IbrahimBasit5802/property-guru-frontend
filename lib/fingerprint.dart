// import 'dart:ffi';
// import 'package:local_auth/error_codes.dart' as auth_error;
// import 'package:local_auth/local_auth.dart';
// final LocalAuthentication auth = LocalAuthentication();
//
//
// Future<bool> canAuthenticate() async  {
//   final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
//   final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
//   return canAuthenticate;
// }
//
//
// try {
// final bool didAuthenticate = await auth.authenticate(
// localizedReason: 'Please authenticate to show account balance',
// options: const AuthenticationOptions(useErrorDialogs: false));
// }
// on PlatformException catch (e) {
// if (e.code == auth_error.notAvailable) {
// // Add handling of no hardware here.
// } else if (e.code == auth_error.notEnrolled) {
// } else {}
// }
