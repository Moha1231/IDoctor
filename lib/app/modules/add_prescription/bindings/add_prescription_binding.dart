import 'package:get/get.dart';

import '../controllers/add_prescription_controller.dart';

class AddPrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPrescriptionController>(
      () => AddPrescriptionController(),
    );
  }
}
