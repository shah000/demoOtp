// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill_flutter_getx/app/modules/otpscreen/bindings/otpscreen_binding.dart';
import 'package:sms_autofill_flutter_getx/app/modules/otpscreen/views/otpscreen_view.dart';
import 'package:sms_autofill_flutter_getx/app/widget/custom_toast.dart';

class PhoneScreenController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool otpVisibility = false.obs;
  String verificationID = "";
  RxBool loadingVerfingPhone = false.obs;
  String phoneNo = '';
  TextEditingController phoneFieldController = TextEditingController();

  Future<void> verifyPhone(String phone) async {
    try {
      loadingVerfingPhone.value = true;

      await auth.verifyPhoneNumber(
        timeout: const Duration(minutes: 2),
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await auth.signInWithCredential(credential).then((value) {
          //   if (kDebugMode) {
          //     print("You are logged in successfully");

          //     Get.to(() => const OtpScreenView(), binding: OtpBinding());
          //   }
          // });
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print(e.message);

            customToast(
                message: e.message.toString(),
                bgColor: Colors.red,
                textColor: Colors.white);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          otpVisibility.value = true;
          verificationID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      Get.to(() => const OtpScreenView(), binding: OtpBinding());

      loadingVerfingPhone.value = false;
    } on FirebaseAuthException catch (e) {
      customToast(
          message: e.message.toString(),
          bgColor: Colors.red,
          textColor: Colors.white);
      loadingVerfingPhone.value = false;
    }
  }
}
