import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';

class TimeSlot {
  TimeSlot(
      {this.timeSlotId,
      this.timeSlot,
      this.duration,
      this.price,
      this.available,
      this.doctorid,
      this.bookByWho,
      this.purchaseTime,
      this.status});
  static const String _timeSlotId = 'timeSlotId';
  static const String _timeSlot = 'timeSlot';
  static const String _duration = 'duration';
  static const String _price = 'price';
  static const String _available = 'available';
  static const String _doctorId = 'doctorId';
  static const String _bookByWho = 'bookByWho';
  static const String _purchaseTime = 'purchaseTime';
  static const String _status = 'status';

  String? timeSlotId;
  DateTime? timeSlot;
  int? duration;
  int? price;
  bool? available;
  String? doctorid;
  UserModel? bookByWho;
  DateTime? purchaseTime;
  String? status;

  factory TimeSlot.fromJson(Map<String, dynamic> jsonData) {
    return TimeSlot(
        timeSlotId: jsonData[_timeSlotId],
        timeSlot: (jsonData[_timeSlot] as Timestamp).toDate(),
        duration: jsonData[_duration],
        price: jsonData[_price],
        available: jsonData[_available],
        doctorid: jsonData[_doctorId],
        bookByWho: jsonData[_bookByWho] != null
            ? UserModel.fromJson(jsonData[_bookByWho])
            : null,
        purchaseTime: jsonData[_purchaseTime] != null
            ? (jsonData[_purchaseTime] as Timestamp).toDate()
            : null,
        status: jsonData[_status]);
  }

  Map<String, dynamic> toMap(TimeSlot timeSlot) {
    return {
      _timeSlot: Timestamp.fromDate(timeSlot.timeSlot!),
      _duration: timeSlot.duration,
      _price: timeSlot.price,
      _available: timeSlot.available,
      _doctorId: timeSlot.doctorid
    };
  }
}
