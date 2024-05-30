import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/services/auth_service.dart';

class ForgotPasswordController extends GetxController {
  void resetPassword(String email) {
    AuthService().resetPassword(email).then((value) {
      Fluttertoast.showToast(
          msg: 'Please check your email for reset your password'.tr,
          toastLength: Toast.LENGTH_LONG);
    });
  }
}
