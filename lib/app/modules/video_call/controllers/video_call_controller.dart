import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/timeslot_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/videocall_service.dart';

class VideoCallController extends GetxController {
  TimeSlot orderedTimeslot = Get.arguments[0]['timeSlot'];
  String token = Get.arguments[0]['token'];
  String room = Get.arguments[0]['room'];
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  bool videoCallEstablished = false;
  late final AgoraClient? client;
  @override
  void onInit() {
    super.onInit();
    initAgora();
  }

  void initAgora() async {
    print('token' + token);
    print('room name : ' + room);
    client = AgoraClient(
      agoraEventHandlers: AgoraEventHandlers(
        userOffline: (i, j) {
          endMeeting();
        },
        leaveChannel: (stats) {
          endMeeting();
        },
      ),
      agoraConnectionData: AgoraConnectionData(
        tempToken: token,
        appId: "5918380664394b78bd3b16842b254f3c",
        channelName: room,
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
    );
    await client!.initialize();
  }

  @override
  void onReady() {
    super.onReady();
    update();
  }

  @override
  void onClose() {
    client!.sessionController.endCall();
  }

  void hangUp() async {
    Get.back();
  }

  void finishVideocall() {
    hangUp();
  }

  endMeeting() async {
    await VideoCallService().removeRoom(orderedTimeslot.timeSlotId!);
    TimeSlotService().setTimeslotFinish(orderedTimeslot);
    client!.sessionController.endCall();
    Get.back();
  }
}
