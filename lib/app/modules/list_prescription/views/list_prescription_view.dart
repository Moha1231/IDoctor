import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/widgets/empty_list_widget.dart';

import '../controllers/list_prescription_controller.dart';

class ListPrescriptionView extends GetView<ListPrescriptionController> {
  const ListPrescriptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription'.tr),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.gotoAddPrescription();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(children: [
            Expanded(
              child: controller.obx(
                  (listPrescription) => ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: listPrescription!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              onTap: () {
                                controller.gotoEditPrescription(
                                    listPrescription[index]);
                              },
                              title: Text(listPrescription[index]
                                  .prescription
                                  .toString()),
                              style: ListTileStyle.drawer,
                              shape: ShapeBorder.lerp(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  1),
                              tileColor: Colors.white12,
                              trailing: IconButton(
                                onPressed: () {
                                  controller.deletePrescription(
                                      listPrescription[index].id ?? '');
                                },
                                icon: Icon(Icons.delete),
                              ));
                        },
                      ),
                  onEmpty: Center(child: EmptyList(msg: 'No Data'.tr))),
            )
          ]),
        ),
      ),
    );
  }
}
