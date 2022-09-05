import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_autofill_flutter_getx/app/modules/phonescreen/phoneScreen_controller.dart';

import '../controllers/otpscreen_controller.dart';

class OtpScreenView extends GetView<OtpController> {
  const OtpScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP View'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Obx(
            () => PinFieldAutoFill(
              textInputAction: TextInputAction.done,
              controller: controller.otpEditingController,
              decoration: UnderlineDecoration(
                textStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                colorBuilder: const FixedColorBuilder(
                  Colors.transparent,
                ),
                bgColorBuilder: FixedColorBuilder(
                  Colors.grey.withOpacity(0.2),
                ),
              ),
              currentCode: controller.messageOtpCode.value,
              onCodeSubmitted: (code) {},
              onCodeChanged: (code) async {
                controller.messageOtpCode.value = code!;
                // controller.countdownController.pause();
                final phoneController = Get.put(PhoneScreenController());
                await controller.signIn(
                    verificationID: phoneController.verificationID,
                    code: controller.messageOtpCode.value);

                if (code.length == 6) {
                  // To perform some operation
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() {
            return controller.loadingSign.value
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    label: const Text('Verify OTP'),
                    icon: const Icon(Icons.verified),
                    onPressed: () async {
                      final phoneController = Get.put(PhoneScreenController());
                      await controller.signIn(
                          verificationID: phoneController.verificationID,
                          code: controller.messageOtpCode.value);
                    },
                  );
          }),
        ]),
      ),
    );
  }
}
