import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

class DoctorService {
  static Doctor? doctor;
  set currentDoctor(Doctor? doctor) => DoctorService.doctor = doctor;

  Future saveDoctorDetail(
      String doctorName,
      String hospital,
      String shortBiography,
      String pictureUrl,
      DoctorCategory doctorCategory) async {
    try {
      CollectionReference doctors =
          FirebaseFirestore.instance.collection('Doctors');
      Map<String, dynamic> doctorsData = {
        'doctorName': doctorName,
        'doctorHospital': hospital,
        'doctorBiography': shortBiography,
        'doctorPicture': pictureUrl,
        'doctorCategory': {
          'categoryId': doctorCategory.categoryId,
          'categoryName': doctorCategory.categoryName
        },
        'doctorBasePrice': 10
      };

      doctors.add(doctorsData).then((value) {
        UserService().setDoctorId(value.id);
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Doctor?> getDoctor() async {
    try {
      if (DoctorService.doctor != null) return DoctorService.doctor;

      var doctorId = await UserService().getDoctorId();
      print('doctor id : ' + doctorId);
      var doctorReference = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctorId)
          .get();

      print('data gaes : ' + doctorReference.data().toString());
      var data = doctorReference.data() as Map<String, dynamic>;
      data['doctorId'] = doctorId;
      Doctor doctor = Doctor.fromJson(data);
      DoctorService.doctor = doctor;
      DoctorService().currentDoctor = doctor;
      return doctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
