import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/submit_button.dart';
import 'package:hallo_doctor_doctor_app/app/modules/withdraw_method/controllers/withdraw_method_controller.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

String method = "Instapay";

class Addinstapay extends GetView<WithdrawMethodController> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Add Instapay',
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color.fromARGB(255, 1, 96, 124))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SafeArea(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.minLength(2),
                      FormBuilderValidators.maxLength(20),
                    ],
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                  onEditingComplete: () => node.nextFocus(),
                ),
                SizedBox(
                  height: 30,
                ),
                FormBuilderTextField(
                  name: 'email',
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.minLength(6),
                      FormBuilderValidators.maxLength(50),
                    ],
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'INSTAPAY EMAIL',
                  ),
                  onEditingComplete: () => node.nextFocus(),
                ),
                SizedBox(
                  height: 30,
                ),
                //FormBuilderTextField(
                // name: 'method',
                // enabled: false,
                // validator: FormBuilderValidators.compose(
                //  [
                //    FormBuilderValidators.minLength(2),
                //  ],
                //   ),
                //   decoration: InputDecoration(
                //    border: OutlineInputBorder(),
                //     hintText: 'Instapay',
                //   ),
                //    onEditingComplete: () => node.nextFocus(),
                //  ),
                //   SizedBox(
                //    height: 30,
                //    ),
                SubmitButton(
                    onTap: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        controller.addPaypal(
                            _formKey.currentState!.value['name'],
                            _formKey.currentState!.value['email'],
                            method);
                        print('validation success');
                      } else {
                        print("validation failed");
                      }
                    },
                    text: 'Save'.tr)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
