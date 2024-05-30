import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset Password.?'.tr,
                style: GoogleFonts.nunito(
                    fontSize: 30, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter Email address associated with your account'.tr,
                style: GoogleFonts.nunito(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              ),
              FormBuilder(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Email'.tr),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(),
                      FormBuilderValidators.required()
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    controller
                        .resetPassword(_formKey.currentState!.value['email']);
                  }
                },
                child: Text('Reset Password'.tr),
              )
            ],
          ),
        ),
      ),
    );
  }
}
