import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';

import '../controllers/add_timeslot_controller.dart';
import 'package:intl/intl.dart';

class AddTimeslotView extends GetView<AddTimeslotController> {
  @override
  Widget build(BuildContext context) {
    List<int> durationList = [20, 30, 45, 60, 90];
    var dropdownDuration = durationList
        .map(
          (e) => DropdownMenuItem(
            value: e.toString(),
            child: Text(e.toString() + ' Minute'),
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Timeslot'),
        actions: controller.editedTimeSlot == null
            ? [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {
                        controller.addTimeslot();
                      },
                      icon: Icon(Icons.add)),
                ),
              ]
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      controller.editTimeSlot();
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.deleteTimeSlot();
                  },
                  icon: Icon(Icons.delete),
                )
              ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FormBuilder(
            key: controller.formKey,
            child: Column(
              children: [
                FormBuilderDateTimePicker(
                  name: 'timeslot',
                  inputType: InputType.time,
                  initialValue: controller.date,
                  format: DateFormat('hh:mm a'),
                  alwaysUse24HourFormat: false,
                  onChanged: (value) {
                    controller.newDateTime = DateTime(
                            controller.date.year,
                            controller.date.month,
                            controller.date.day,
                            value!.hour,
                            value.minute)
                        .toLocal();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.access_time),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  name: 'Price',
                  initialValue: (controller.price ?? '').toString(),
                  decoration: InputDecoration(
                      hintText: 'Price',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.attach_money)),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.numeric(context),
                    FormBuilderValidators.max(context, 100),
                  ]),
                  onSaved: (price) {
                    controller.price = int.parse(price!);
                  },
                ),
                Divider(),
                FormBuilderDropdown(
                  initialValue: controller.duration.toString(),
                  name: 'Duration',
                  items: dropdownDuration,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.timer),
                  ),
                  onChanged: (duration) {
                    controller.duration = int.parse(duration.toString());
                  },
                ),
                Divider(),
                FormBuilderDateTimePicker(
                  name: 'Date',
                  inputType: InputType.date,
                  initialValue: controller.date,
                  format: DateFormat('EEEE, dd MMMM, y'),
                  onChanged: (dateTime) {
                    controller.date = dateTime!;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.date_range_outlined)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
