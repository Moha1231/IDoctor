import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hallo_doctor_doctor_app/app/modules/order/controllers/order_controller.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(index) => _selectedIndex.value = index;
  @override
  void onClose() {}

  void initTabAppointment() {
    // interval(count1, (_) => print("interval $_"), time: Duration(seconds: 1));
    Get.find<AppointmentController>().initDoctorSchedule();
    print('init appointment');
  }

  void initTabOrder() {
    Get.find<OrderController>().initOrderedTimeSlot();
  }
}
