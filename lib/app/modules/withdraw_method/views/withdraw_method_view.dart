import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withdraw_method/views/add_paypal_page.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withdraw_method/views/add_insta_pay.dart';

import '../controllers/withdraw_method_controller.dart';
import 'widgets/withdraw_method_tile.dart';

class WithdrawMethodView extends GetView<WithdrawMethodController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Withdraw Method'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 1, 96, 124)),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                // title: "Chose Withdraw Provider".tr,
                //  backgroundColor: Color.fromARGB(255, 1, 135, 147),
                //  titleStyle: GoogleFonts.cairo(color: Colors.white),
                //  middleTextStyle: GoogleFonts.cairo(color: Colors.white),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  // Column
                  // height: 250,
                  // width: 250,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                //   iconSize: 10,
                                icon: Image.asset('assets/images/download1.png',
                                    height: 150, width: 150),
                                onPressed: () {
                                  Get.off(() => AddPaypalPage());
                                },
                              ),
                              //    Spacer(),

                              IconButton(
                                //  iconSize: 10,
                                icon: Image.asset('assets/images/download2.png',
                                    height: 150, width: 150),
                                onPressed: () {
                                  Get.off(() => Addinstapay());
                                },
                              ),
                            ]),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('Cancel'.tr,
                                        style: GoogleFonts.cairo()))),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                barrierColor: Color.fromRGBO(255, 255, 255, 0.5),
                enableDrag: false,
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        child: controller.obx(
          (listWithdrawMethod) => ListView.builder(
            shrinkWrap: true,
            itemCount: listWithdrawMethod!.length,
            itemBuilder: (contex, index) => WithdrawMethodTile(
              name: listWithdrawMethod[index].name!,
              email: listWithdrawMethod[index].email!,
              method: listWithdrawMethod[index].method!,
              onTap: () =>
                  controller.toWithdrawDetail(listWithdrawMethod[index]),
            ),
          ),
          onEmpty: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                'you don\'t have a withdrawal method, please add one, to withdraw your money'
                    .tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
