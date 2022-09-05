// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:sms_autofill_flutter_getx/app/modules/otpscreen/bindings/otpscreen_binding.dart';
import 'package:sms_autofill_flutter_getx/app/modules/phonescreen/phoneScreen_bindings.dart';
import 'package:sms_autofill_flutter_getx/app/modules/phonescreen/phoneScreen_page.dart';

import '../modules/otpscreen/views/otpscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.phoneScreen;
  static const Home = Routes.otp;

  static final routes = [
    GetPage(
      name: _Paths.phoneScreen,
      page: () => PhoneScreenPage(),
      binding: PhoneScreenBindings(),
    ),
    GetPage(
      name: _Paths.otp,
      page: () => const OtpScreenView(),
      binding: OtpBinding(),
    ),
  ];
}
