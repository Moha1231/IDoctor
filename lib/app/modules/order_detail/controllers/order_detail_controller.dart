import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';

class OrderDetailController extends GetxController {
  final count = 0.obs;
  TimeSlot orderedTimeslot = Get.arguments;
  var database = FirebaseDatabase.instance.ref();
  @override
  void onClose() {}
  void increment() => count.value++;
  void videoCall() {
    //Get.toNamed('/video-call', arguments: orderedTimeslot);
    try {
      final roomData = <String, dynamic>{
        'timeSlotId': orderedTimeslot.timeSlotId,
      };
      database.child('room/' + orderedTimeslot.timeSlotId!).set(roomData);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
