import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/notification_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/videocall_service.dart';

class OrderDetailController extends GetxController {
  final count = 0.obs;
  TimeSlot orderedTimeslot = Get.arguments;
  var database = FirebaseDatabase.instance.ref();
  NotificationService notificationService = Get.find<NotificationService>();
  @override
  void onClose() {}
  void increment() => count.value++;
  void videoCall() async {
    //
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var token =
          await VideoCallService().getAgoraToken(orderedTimeslot.timeSlotId!);
      final roomData = <String, dynamic>{
        'room': orderedTimeslot.timeSlotId,
        'token': token
      };
      database.child('room/' + orderedTimeslot.timeSlotId!).set(roomData);
      notificationService.notificationStartAppointment(
          DoctorService.doctor!.doctorName!,
          orderedTimeslot.bookByWho!.userId!);
      EasyLoading.dismiss();
      Get.toNamed(
        '/video-call',
        arguments: [
          {
            'token': token,
            'room': orderedTimeslot.timeSlotId,
            'timeSlot': orderedTimeslot
          }
        ],
      );
    } catch (e) {
      printError(info: e.toString());
      Fluttertoast.showToast(msg: e.toString());
      EasyLoading.dismiss();
    }
  }
}
