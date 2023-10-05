import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/prescription_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/prescription_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

class AddPrescriptionController extends GetxController {
  var formKey = GlobalKey<FormBuilderState>();
  TimeSlot timeSlot = Get.arguments[0];
  PrescriptionModel? editedPrescription = Get.arguments[1];
  var isEdited = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (editedPrescription != null) {
      isEdited.value = true;
      formKey.currentState!.fields['prescription']!
          .didChange(editedPrescription!.prescription);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updatePrescription() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var data = await Get.defaultDialog<bool>(
          title: 'Confirmation',
          middleText: 'Confirm edited prescription'.tr,
          textCancel: 'Cancel',
          textConfirm: 'OK',
          onCancel: () {},
          onConfirm: () {
            Get.back(result: true);
          });
      if (data != null && data) {
        EasyLoading.show(status: 'Saving...');
        PrescriptionModel updatedPrescription = editedPrescription!.copyWith(
            prescription: formKey.currentState!.fields['prescription']!.value);
        await PrescriptionService().updatePrescription(updatedPrescription);
        EasyLoading.dismiss();
        Get.back(result: updatedPrescription);
      }
    }
  }

  void addPrescription() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var data = await Get.defaultDialog<bool>(
          title: 'Confirmation',
          middleText:
              'Are you sure you want to add a prescription for this client?'.tr,
          textCancel: 'Cancel',
          textConfirm: 'OK',
          onCancel: () {},
          onConfirm: () {
            Get.back(result: true);
          });
      if (data != null && data) {
        EasyLoading.show(status: 'Saving...');
        PrescriptionModel prescriptionModel = PrescriptionModel(
          prescription: formKey.currentState!.fields['prescription']!.value,
          userId: timeSlot.bookByWho!.userId ?? '',
          doctorId: timeSlot.doctorid,
          userDoctorId: UserService().user.userId,
          createdAt: DateTime.now(),
          timeSlotId: timeSlot.timeSlotId,
        );
        PrescriptionModel newPrescriptionWithId =
            await PrescriptionService().addPrescription(prescriptionModel);
        EasyLoading.dismiss();
        Get.back(result: newPrescriptionWithId);
      }
    }
  }
}
