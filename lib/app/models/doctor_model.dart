import 'dart:core';

import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';

class Doctor {
  Doctor({
    required this.doctorId,
    required this.doctorName,
    required this.doctorPicture,
    required this.doctorPrice,
    required this.doctorShortBiography,
    required this.doctorCategory,
    required this.doctorHospital,
    required this.doctorBalance,
    required this.accountStatus,
  });
  static const String _doctorId = 'doctorId';
  static const String _doctorName = 'doctorName';
  static const String _doctorPicture = 'doctorPicture';
  static const String _doctorPrice = 'doctorBasePrice';
  static const String _doctorShortBiography = 'doctorBiography';
  static const String _doctorCategory = 'doctorCategory';
  static const String _doctorHospital = 'doctorHospital';
  static const String _doctorBalance = 'balance';
  static const String _accountStatus = 'accountStatus';
  String? doctorId;
  String? doctorName;
  String? doctorPicture;
  int? doctorPrice;
  String? doctorShortBiography;
  DoctorCategory? doctorCategory;
  String? doctorHospital;
  int? doctorBalance;
  String? accountStatus;

  factory Doctor.fromJson(Map<String, dynamic> data) {
    return Doctor(
        doctorId: data[_doctorId],
        doctorName: data[_doctorName],
        doctorPicture: data[_doctorPicture],
        doctorPrice: data[_doctorPrice],
        doctorShortBiography: data[_doctorShortBiography],
        doctorCategory: DoctorCategory.fromJson(data[_doctorCategory]),
        doctorHospital: data[_doctorHospital],
        doctorBalance: data[_doctorBalance] ?? 0,
        accountStatus: data[_accountStatus]);
  }
}
