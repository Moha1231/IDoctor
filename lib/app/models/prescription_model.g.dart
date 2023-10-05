// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrescriptionModelImpl _$$PrescriptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PrescriptionModelImpl(
      id: json['id'] as String?,
      timeSlotId: json['timeSlotId'] as String?,
      doctorId: json['doctorId'] as String?,
      userId: json['userId'] as String?,
      userDoctorId: json['userDoctorId'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      prescription: json['prescription'] as String?,
    );

Map<String, dynamic> _$$PrescriptionModelImplToJson(
        _$PrescriptionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeSlotId': instance.timeSlotId,
      'doctorId': instance.doctorId,
      'userId': instance.userId,
      'userDoctorId': instance.userDoctorId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'prescription': instance.prescription,
    };
