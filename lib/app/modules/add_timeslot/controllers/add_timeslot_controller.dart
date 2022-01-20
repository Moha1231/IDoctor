import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hallo_doctor_doctor_app/app/services/timeslot_service.dart';

class AddTimeslotController extends GetxController {
  late TimeOfDay timeSlot;
  DateTime date = Get.arguments[0]['date'].toLocal();
  late DateTime newDateTime;
  TimeSlot? editedTimeSlot = Get.arguments[0]['timeSlot'];
  int? price;
  int? duration = 20;
  bool available = true;
  final formKey = GlobalKey<FormBuilderState>();
  AppointmentController appointController = Get.find();
  @override
  void onInit() {
    super.onInit();
    if (editedTimeSlot != null) {
      print('edit mode');
      newDateTime = date;
      price = editedTimeSlot!.price;
      duration = editedTimeSlot!.duration;
      timeSlot = TimeOfDay.fromDateTime(editedTimeSlot!.timeSlot!);
    } else {
      newDateTime = date;
      timeSlot = TimeOfDay.fromDateTime(date);
      print('add mode ' + date.toString());
      print('timeslot ' + timeSlot.toString());
    }
  }

  @override
  void onClose() {}

  void addTimeslot() {
    if (newDateTime.compareTo(DateTime.now()) < 0) {
      print('date time : ' + date.toString());
      Fluttertoast.showToast(msg: 'date time is in the past');
      return;
    }
    final validationSuccess = formKey.currentState!.validate();
    if (validationSuccess) {
      formKey.currentState!.save();
      TimeSlotService()
          .saveDoctorTimeslot(
              dateTime: newDateTime,
              price: price!,
              duration: duration!,
              available: available)
          .then((value) {
        Fluttertoast.showToast(msg: 'success adding timeslot');
        appointController.updateEventsCalendar();
      }).catchError((err) {
        Fluttertoast.showToast(msg: err.toString());
      });
      Get.back();
    }
  }

  void editTimeSlot() {
    if (newDateTime.compareTo(DateTime.now()) < 0) {
      Fluttertoast.showToast(msg: 'date time is in the past');
      return;
    }
    final validationSuccess = formKey.currentState!.validate();
    if (validationSuccess) {
      formKey.currentState!.save();
      editedTimeSlot!.timeSlot = newDateTime;
      editedTimeSlot!.price = price;
      editedTimeSlot!.duration = duration;
      TimeSlotService().updateTimeSlot(editedTimeSlot!).then((value) {
        Fluttertoast.showToast(msg: 'success editing timeslot');
        appointController.updateEventsCalendar();
        Get.back();
      });
    }
  }

  Future deleteTimeSlot() async {
    bool? delete = await Get.defaultDialog(
      title: 'Delete Time Slot',
      middleText: 'are you sure you want to delete this timeslot',
      radius: 15,
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      onConfirm: () {
        TimeSlotService().deleteTimeSlot(editedTimeSlot!).then((value) {
          Fluttertoast.showToast(msg: 'success delete timeslot');
          appointController.updateEventsCalendar();
          Get.back(result: true);
        });
      },
    );

    if (delete == true) {
      print('masuk sini gaess : ' + delete.toString());
      Get.back();
    }
    print('masuk sini gaess : ' + delete.toString());
  }
}
