import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/withdraw_method_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/withdraw_service.dart';
import 'package:hallo_doctor_doctor_app/app/utils/exceptions.dart';

class WithdrawMethodController extends GetxController
    with StateMixin<List<WithdrawMethod>> {
  final amount = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    getAllPaymentMethod();
  }

  void addPaypal(String name, String email, String method) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    WithdrawService().addPaypalMethod(name, email, method).then((value) {
      Get.back();
      getAllPaymentMethod();
    }).whenComplete(() => EasyLoading.dismiss());
  }

  getAllPaymentMethod() async {
    change([], status: RxStatus.loading());
    WithdrawService().getWithdrawMethod().then((value) {
      if (value.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      change(value, status: RxStatus.success());
    }).catchError((err) {
      exceptionToast(err.toString());
      change([], status: RxStatus.error(err.toString()));
    });
  }

  toWithdrawDetail(WithdrawMethod withdrawMethod) {
    Get.toNamed('/withdraw-detail', arguments: [
      {'withdrawMethod': withdrawMethod, 'amount': amount}
    ]);
  }
}
