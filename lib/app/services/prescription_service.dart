import 'package:firebase_core/firebase_core.dart';
import 'package:hallo_doctor_doctor_app/app/collection/firebase_collection.dart';
import 'package:hallo_doctor_doctor_app/app/models/prescription_model.dart';

class PrescriptionService {
  Future<List<PrescriptionModel>> getPrescriptionByTimeSlotId(
      String timeSlotId) async {
    try {
      var listPrescriptionRef = await FirebaseCollection()
          .prescriptionCol
          .where('timeSlotId', isEqualTo: timeSlotId)
          .get();
      List<PrescriptionModel> listPrescription =
          listPrescriptionRef.docs.map((e) => e.data()).toList();

      return listPrescription;
    } on FirebaseException catch (e) {
      return Future.error(e.message ?? e.toString());
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Add Prescription
  Future<PrescriptionModel> addPrescription(
      PrescriptionModel prescription) async {
    try {
      var prescriptionRef =
          await FirebaseCollection().prescriptionCol.add(prescription);
      PrescriptionModel newPrescriptionWithId =
          prescription.copyWith(id: prescriptionRef.id);
      return newPrescriptionWithId;
    } on FirebaseException catch (e) {
      return Future.error(e.message ?? e.toString());
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Update Prescription
  Future<void> updatePrescription(PrescriptionModel prescription) async {
    try {
      await FirebaseCollection()
          .prescriptionCol
          .doc(prescription.id)
          .update(prescription.toJson());
    } on FirebaseException catch (e) {
      return Future.error(e.message ?? e.toString());
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Delete Prescription by id
  Future deletePrescriptionById(String prescriptionId) async {
    try {
      await FirebaseCollection().prescriptionCol.doc(prescriptionId).delete();
    } on FirebaseException catch (e) {
      return Future.error(e.message ?? e.toString());
    } catch (e) {
      return Future.error(e);
    }
  }
}
