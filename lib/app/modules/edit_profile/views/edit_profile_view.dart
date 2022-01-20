import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

import '../controllers/edit_profile_controller.dart';
import 'widgets/edit_profile_tile.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Account',
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Container(
          child: GetX<EditProfileController>(
            builder: (controller) => Column(
              children: [
                EditProfileTile(
                  title: 'Username',
                  subtitle: controller.username.value,
                ),
                Divider(
                  height: 0,
                ),
                EditProfileTile(
                  title: 'Email',
                  subtitle: controller.email.value,
                  onTap: () {
                    controller.toUpdateEmail();
                  },
                ),
                Divider(
                  height: 0,
                ),
                EditProfileTile(
                  title: 'Password',
                  subtitle: controller.password,
                  onTap: () {
                    controller.toChangePassword();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
