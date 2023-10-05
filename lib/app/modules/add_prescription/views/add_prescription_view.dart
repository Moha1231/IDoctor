import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/submit_button.dart';

import '../controllers/add_prescription_controller.dart';

class AddPrescriptionView extends GetView<AddPrescriptionController> {
  const AddPrescriptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Obx(
                () => controller.isEdited.value
                    ? Text('Edit Prescription'.tr)
                    : Text('Add Prescription'.tr),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    if (controller.isEdited.value) {
                      controller.updatePrescription();
                      return;
                    }
                    controller.addPrescription();
                  },
                  icon: Icon(Icons.done),
                )
              ]),
          body: Container(
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 201, 201, 201),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FormBuilderTextField(
                              name: 'prescription',
                              maxLines: 10,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Prescription for this patient'.tr),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
