import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './homescreen_controller.dart';

class HomescreenPage extends GetView<HomescreenController> {
    
    const HomescreenPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('HomescreenPage'),),
            body: Container(),
        );
    }
}