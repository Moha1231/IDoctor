import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_doctor_app/app/modules/order_detail/views/widgets/video_call_button.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';
import 'package:hallo_doctor_doctor_app/app/utils/timeformat.dart';

import '../controllers/order_detail_controller.dart';
import 'widgets/user_order_tile.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Order Detail',
          style: Styles.appBarTextStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Appointment With',
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              UserOrderTile(
                  imgUrl: controller.orderedTimeslot.bookByWho!.photoUrl!,
                  name: controller.orderedTimeslot.bookByWho!.displayName!,
                  orderTime: controller.orderedTimeslot.purchaseTime!),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Appointment Detail',
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x04000000),
                          blurRadius: 10,
                          spreadRadius: 10,
                          offset: Offset(0.0, 8.0))
                    ],
                    color: Colors.white),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Table(
                      children: [
                        TableRow(children: [
                          SizedBox(height: 50, child: Text('Appointment Time')),
                          SizedBox(
                              height: 50,
                              child: Text(TimeFormat().formatDate(
                                  controller.orderedTimeslot.timeSlot!))),
                        ]),
                        TableRow(children: [
                          SizedBox(height: 50, child: Text('Duration')),
                          SizedBox(
                              height: 50,
                              child: Text(': ' +
                                  controller.orderedTimeslot.duration
                                      .toString() +
                                  ' Minute')),
                        ]),
                        TableRow(children: [
                          SizedBox(height: 50, child: Text('Price')),
                          SizedBox(
                            height: 50,
                            child: Text(
                              currencySign +
                                  controller.orderedTimeslot.price.toString() +
                                  ' (Paid)',
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Countdown',
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CountDownText(
                due: controller.orderedTimeslot.timeSlot!.toLocal(),
                finishedText: "",
                showLabel: true,
                longDateName: true,
                style: GoogleFonts.nunito(
                    color: Styles.primaryBlueColor, fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              videoCallButton(
                  onTap: () {
                    Get.defaultDialog(
                        title: 'Start Appointment',
                        content: Text(
                            'are you sure you want to start the virtual meeting now, the user will be sent a notification that you have started the meeting'),
                        textCancel: 'Cancel',
                        textConfirm: "Start Appointment",
                        onConfirm: () {
                          Get.back();
                          controller.videoCall();
                        });
                  },
                  text: 'Start Appointment'),
              SizedBox(
                height: 10,
              ),
              Text(
                'You can still start a video call appointment, even before the schedule',
                style: Styles.greyTextInfoStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
