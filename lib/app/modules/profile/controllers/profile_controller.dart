import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/services/auth_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  var user = UserService().currentUser;
  bool tap = false;
  var photoUrl = ''.obs;
  var displayName = ''.obs;
  @override
  void onReady() async {
    super.onReady();
    photoUrl.value = await UserService().getPhotoUrl();
    update();
  }

  @override
  void onClose() {}

  void toEditProfile() {
    Get.toNamed('/edit-profile');
  }

  void toBalance() {
    Get.toNamed('/balance');
  }

  void toEditDoctorDetail() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var doctor = DoctorService.doctor;
    EasyLoading.dismiss();
    Get.toNamed('/add-doctor-detail', arguments: doctor);
  }

  void logout() async {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'are you sure you want to Logout',
      radius: 15,
      textCancel: 'Cancel',
      textConfirm: 'Logout',
      onConfirm: () {
        AuthService().logout();
        Get.offAllNamed('/login');
      },
    );
  }
}
