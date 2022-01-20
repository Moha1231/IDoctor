import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/timeslot_service.dart';

class VideoCallController extends GetxController {
  TimeSlot orderedTimeslot = Get.arguments;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "5918380664394b78bd3b16842b254f3c",
      channelName: "test",
    ),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );
  @override
  void onInit() {
    super.onInit();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  void onReady() {
    super.onReady();
    update();
  }

  @override
  void onClose() {}

  void hangUp() async {
    Get.back();
  }

  void finishVideocall() {
    TimeSlotService().setTimeslotFinish(orderedTimeslot);
    hangUp();
  }
}
