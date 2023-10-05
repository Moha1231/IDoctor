import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/prescription_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/routes/app_pages.dart';
import 'package:hallo_doctor_doctor_app/app/services/prescription_service.dart';

class ListPrescriptionController extends GetxController
    with StateMixin<List<PrescriptionModel>> {
  List<PrescriptionModel> listPrescription = [];
  TimeSlot timeSlot = Get.arguments;
  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    try {
      listPrescription = await PrescriptionService()
          .getPrescriptionByTimeSlotId(timeSlot.timeSlotId!);
      if (listPrescription.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(listPrescription, status: RxStatus.success());
      }
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void gotoAddPrescription() async {
    var data =
        await Get.toNamed(Routes.ADD_PRESCRIPTION, arguments: [timeSlot, null]);
    PrescriptionModel? newPrescription = data as PrescriptionModel?;
    if (newPrescription != null) {
      _addPrescription(newPrescription);
    }
  }

  void _addPrescription(PrescriptionModel prescription) {
    listPrescription = [...listPrescription, prescription];
    change(listPrescription, status: RxStatus.success());
  }

  void _updatePrescription(PrescriptionModel editedPrescription) {
    int index = listPrescription
        .indexWhere((prescription) => prescription.id == editedPrescription.id);
    if (index != -1) {
      listPrescription[index] = editedPrescription;
      change(listPrescription, status: RxStatus.success());
    }
  }

  void gotoEditPrescription(PrescriptionModel editedPrescription) async {
    var data = await Get.toNamed(Routes.ADD_PRESCRIPTION,
        arguments: [timeSlot, editedPrescription]);
    PrescriptionModel? newEditedPrescription = data as PrescriptionModel?;
    if (newEditedPrescription != null) {
      _updatePrescription(newEditedPrescription);
    }
  }

  void deletePrescription(String prescriptionId) async {
    try {
      var isConfirm = await Get.defaultDialog<bool>(
          title: 'Confirmation',
          middleText: 'Message confirm delete prescription'.tr,
          textCancel: 'Cancel',
          textConfirm: 'OK',
          onCancel: () {},
          onConfirm: () {
            Get.back(result: true);
          });
      if (isConfirm != null && isConfirm) {
        EasyLoading.show(status: 'Saving...');
        await PrescriptionService().deletePrescriptionById(prescriptionId);

        /// Start the operation
        EasyLoading.dismiss();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    listPrescription
        .removeWhere((prescription) => prescription.id == prescriptionId);
    change(listPrescription, status: RxStatus.success());
  }
}
