import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/services/auth_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

class DeleteAccountController extends GetxController {
  //TODO: Implement DeleteAccountController

  TextEditingController textPermanentDeleteController = TextEditingController();
  String permanentlyDeleteText = 'PERMANENTLY DELETE';
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void deleteAccount() {
    if (textPermanentDeleteController.text == permanentlyDeleteText) {
      Get.defaultDialog(
          title: 'Alert',
          content: Text(
              'Are you sure you wanto delete your account, you can still cancel it'
                  .tr),
          textConfirm: 'Delete My Account'.tr,
          textCancel: 'Cancel'.tr,
          onConfirm: confirmDeleteAccount);
    } else {
      Fluttertoast.showToast(msg: 'Text Wrong'.tr);
    }
  }

  void confirmDeleteAccount() async {
    EasyLoading.show();
    try {
      await UserService().deleteAccountPermanently();
      AuthService().logout();
      Get.offAllNamed('/login');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error Delete Account');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
