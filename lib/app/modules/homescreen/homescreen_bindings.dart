import 'package:get/get.dart';
import './homescreen_controller.dart';

class HomescreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(HomescreenController());
    }
}