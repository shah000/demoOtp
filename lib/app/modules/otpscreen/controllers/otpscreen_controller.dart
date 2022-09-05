import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_autofill_flutter_getx/app/modules/homescreen/homescreen_page.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../../widget/custom_toast.dart';
import '../../homescreen/homescreen_bindings.dart';

class OtpController extends GetxController {
  CountdownController countdownController = CountdownController();
  TextEditingController otpEditingController = TextEditingController();
  var messageOtpCode = ''.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool otpVisibility = false.obs;

  RxBool loadingSign = false.obs;
  String phoneNo = '';
  @override
  void onInit() async {
    super.onInit();
    if (kDebugMode) {
      print(await SmsAutoFill().getAppSignature);
    }
    // Listen for SMS OTP
    await SmsAutoFill().listenForCode();
  }

  @override
  void onReady() {
    super.onReady();
    countdownController.start();
  }

  @override
  void onClose() {
    super.onClose();
    otpEditingController.dispose();
    SmsAutoFill().unregisterListener();
  }

  Future<void> signIn(
      {required String verificationID, required String code}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: code);
    loadingSign.value = true;

    try {
      await auth.signInWithCredential(credential).then((value) {
        if (kDebugMode) {
          print("You are logged in successfully");
        }
        try {
          customToast(
              message: 'You are logged in successfully',
              bgColor: Colors.green,
              textColor: Colors.white);

          Get.offAll(() => const HomescreenPage(),
              binding: HomescreenBindings());
          loadingSign.value = false;
        } on FirebaseAuthException catch (e) {
          customToast(
              message: e.message.toString(),
              bgColor: Colors.red,
              textColor: Colors.white);
          loadingSign.value = false;
        }
      });
    } on FirebaseAuthException catch (e) {
      customToast(
          message: e.message.toString(),
          bgColor: Colors.red,
          textColor: Colors.white);
    }
    loadingSign.value = false;
  }
}
