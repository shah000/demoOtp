import 'package:get/get.dart';
import './phoneScreen_controller.dart';

class PhoneScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(PhoneScreenController());
    }
}