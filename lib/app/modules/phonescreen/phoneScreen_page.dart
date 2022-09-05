// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './phoneScreen_controller.dart';

class PhoneScreenPage extends GetView<PhoneScreenController> {
  PhoneScreenPage({Key? key}) : super(key: key);

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(),
                TextFormField(
                  controller: controller.phoneFieldController,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please Enter  Phone Number ';
                    } else if (val.length < 10) {
                      return 'Please Enter Correct Phone Number ';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: 'Enter Phone Number',
                      border: OutlineInputBorder(),
                      prefix: Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: Text("+92"),
                      )),
                ),
                Obx(() {
                  return controller.loadingVerfingPhone.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton.icon(
                          label: const Text('Send OTP'),
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              String phoneNo =
                                  '+92${controller.phoneFieldController.text}';
                              await controller.verifyPhone(phoneNo);
                              controller.phoneNo = phoneNo;
                            }
                          },
                        );
                }),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
