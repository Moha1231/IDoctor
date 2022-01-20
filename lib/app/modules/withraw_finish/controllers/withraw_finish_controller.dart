import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/balance/controllers/balance_controller.dart';

class WithrawFinishController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  late AnimationController animController;
  @override
  void onInit() {
    super.onInit();
    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  ok() {
    Get.back();
    BalanceController().initBalance();
  }
}
