import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

import '../controllers/profile_controller.dart';
import 'widgets/profile_button.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.blue[400]),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: GetX<ProfileController>(
                builder: (_) {
                  return Row(
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: controller.photoUrl.value.isEmpty
                              ? null
                              : CachedNetworkImageProvider(
                                  controller.photoUrl.value)),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.user!.displayName!,
                            style: GoogleFonts.inter(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.user!.email!,
                            style: GoogleFonts.inter(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ProfileButton(
            onTap: () {
              controller.toEditProfile();
            },
            icon: Icons.person,
            text: 'Edit Account',
          ),
          ProfileButton(
            onTap: () {
              controller.toEditDoctorDetail();
            },
            icon: Icons.edit,
            text: 'Edit Doctor Data',
          ),
          ProfileButton(
            onTap: () {
              controller.toBalance();
            },
            icon: Icons.account_balance_wallet_rounded,
            text: 'Balance',
          ),
          SizedBox(
            height: 20,
          ),
          ProfileButton(
            onTap: () {
              controller.logout();
            },
            icon: Icons.logout_outlined,
            text: 'Logout',
            hideArrowIcon: true,
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       controller.test();
          //     },
          //     child: Text('test'))
        ],
      ),
    );
  }
}
