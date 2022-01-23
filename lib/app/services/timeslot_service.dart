import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';

class TimeSlotService {
  Future saveDoctorTimeslot(
      {required DateTime dateTime,
      required int price,
      required int duration,
      required bool available}) async {
    TimeSlot timeSlot = TimeSlot();
    timeSlot.timeSlot = dateTime;
    timeSlot.price = price;
    timeSlot.duration = duration;
    timeSlot.available = available;
    timeSlot.doctorid = DoctorService.doctor!.doctorId;
    try {
      await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .add(TimeSlot().toMap(timeSlot));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future updateTimeSlot(TimeSlot timeSlot) async {
    try {
      print('doctor id : ' + DoctorService.doctor!.doctorId!);
      print('timeslot update id : ' + timeSlot.timeSlotId!);
      await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .doc(timeSlot.timeSlotId)
          .update(TimeSlot().toMap(timeSlot));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteTimeSlot(TimeSlot timeSlot) async {
    try {
      await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .doc(timeSlot.timeSlotId)
          .delete();
      print('success delete timeslot');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<TimeSlot>> getDoctorTimeSlot() async {
    try {
      var doctor = await DoctorService().getDoctor();
      var documentRef = await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .where('doctorId', isEqualTo: doctor!.doctorId)
          .get();

      if (documentRef.docs.isEmpty) return [];

      List<TimeSlot> listTimeslot = documentRef.docs.map((doc) {
        var data = doc.data();
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        return timeSlot;
      }).toList();
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //get all timeslot that user, succesfully purchase
  Future<List<TimeSlot>> getOrderedTimeSlot({int? limit}) async {
    try {
      var doctor = await DoctorService().getDoctor();
      var documentRef = FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .where('doctorId', isEqualTo: doctor!.doctorId)
          .where('charged', isEqualTo: true);
      var documentSnapshot = limit == null
          ? await documentRef.get()
          : await documentRef.limit(limit).get();

      if (documentSnapshot.docs.isEmpty) {
        return [];
      }

      List<TimeSlot> listTimeslot = documentSnapshot.docs.map((doc) {
        var data = doc.data();
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        return timeSlot;
      }).toList();

      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setTimeslotFinish(TimeSlot timeSlot) async {
    try {
      var timeSlotRef = await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .doc(timeSlot.timeSlotId)
          .get();
      await timeSlotRef.reference.update({'status': 'complete'});
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
