import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/user_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class VideoCallJitsiController extends GetxController {
  //TODO: Implement VideoCallJitsiController

  bool audioMuted = true;
  bool videoMuted = true;
  bool screenShareOn = false;
  List<String> participants = [];
  // final _jitsiMeetPlugin = JitsiMeet();
  UserModel? userModel = UserService().user;
  Doctor? doctor = DoctorService.doctor;
  TimeSlot timeSlot = Get.arguments;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void openJitsi() async {
    await LaunchApp.openApp(
      androidPackageName: 'org.jitsi.meet',
      // openStore: false
    );
  }

  // void join() async {
  //   var options = JitsiMeetConferenceOptions(
  //     room: timeSlot.timeSlotId.toString(),
  //     configOverrides: {
  //       "startWithAudioMuted": false,
  //       "startWithVideoMuted": false,
  //       "subject": "Appointment"
  //     },
  //     featureFlags: {
  //       "unsaferoomwarning.enabled": false,
  //       "ios.screensharing.enabled": true
  //     },
  //     userInfo: JitsiMeetUserInfo(
  //         displayName: userModel?.displayName ?? 'doctor',
  //         email: userModel?.email ?? '',
  //         avatar: doctor?.doctorPicture ?? ''),
  //   );

  //   var listener = JitsiMeetEventListener(
  //     conferenceJoined: (url) {
  //       debugPrint("conferenceJoined: url: $url");
  //     },
  //     conferenceTerminated: (url, error) {
  //       debugPrint("conferenceTerminated: url: $url, error: $error");
  //     },
  //     conferenceWillJoin: (url) {
  //       debugPrint("conferenceWillJoin: url: $url");
  //     },
  //     participantJoined: (email, name, role, participantId) {
  //       debugPrint(
  //         "participantJoined: email: $email, name: $name, role: $role, "
  //         "participantId: $participantId",
  //       );
  //       participants.add(participantId!);
  //     },
  //     participantLeft: (participantId) {
  //       debugPrint("participantLeft: participantId: $participantId");
  //     },
  //     audioMutedChanged: (muted) {
  //       debugPrint("audioMutedChanged: isMuted: $muted");
  //     },
  //     videoMutedChanged: (muted) {
  //       debugPrint("videoMutedChanged: isMuted: $muted");
  //     },
  //     endpointTextMessageReceived: (senderId, message) {
  //       debugPrint(
  //           "endpointTextMessageReceived: senderId: $senderId, message: $message");
  //     },
  //     screenShareToggled: (participantId, sharing) {
  //       debugPrint(
  //         "screenShareToggled: participantId: $participantId, "
  //         "isSharing: $sharing",
  //       );
  //     },
  //     chatMessageReceived: (senderId, message, isPrivate, timestamp) {
  //       debugPrint(
  //         "chatMessageReceived: senderId: $senderId, message: $message, "
  //         "isPrivate: $isPrivate, timestamp: $timestamp",
  //       );
  //     },
  //     chatToggled: (isOpen) => debugPrint("chatToggled: isOpen: $isOpen"),
  //     participantsInfoRetrieved: (participantsInfo) {
  //       debugPrint(
  //           "participantsInfoRetrieved: participantsInfo: $participantsInfo, ");
  //     },
  //     readyToClose: () {
  //       debugPrint("readyToClose");
  //     },
  //   );
  //   await _jitsiMeetPlugin.join(options, listener);
  // }

  void copyRoomName() async {
    String timeSlotId = timeSlot.timeSlotId ?? '';
    await Clipboard.setData(ClipboardData(text: timeSlotId));
    Fluttertoast.showToast(msg: 'Room Name Copied ${timeSlot.timeSlotId}'.tr);
  }

  // hangUp() async {
  //   await _jitsiMeetPlugin.hangUp();
  // }

  // setAudioMuted(bool? muted) async {
  //   var a = await _jitsiMeetPlugin.setAudioMuted(muted!);
  //   debugPrint("$a");
  //   // setState(() {
  //   //   audioMuted = muted;
  //   // });
  // }

  // setVideoMuted(bool? muted) async {
  //   var a = await _jitsiMeetPlugin.setVideoMuted(muted!);
  //   debugPrint("$a");
  //   // setState(() {
  //   //   videoMuted = muted;
  //   // });
  // }

  // sendEndpointTextMessage() async {
  //   var a = await _jitsiMeetPlugin.sendEndpointTextMessage(message: "HEY");
  //   debugPrint("$a");

  //   for (var p in participants) {
  //     var b =
  //         await _jitsiMeetPlugin.sendEndpointTextMessage(to: p, message: "HEY");
  //     debugPrint("$b");
  //   }
  // }

  // toggleScreenShare(bool? enabled) async {
  //   await _jitsiMeetPlugin.toggleScreenShare(enabled!);

  //   // setState(() {
  //   //   screenShareOn = enabled;
  //   // });
  // }

  // openChat() async {
  //   await _jitsiMeetPlugin.openChat();
  // }

  // sendChatMessage() async {
  //   var a = await _jitsiMeetPlugin.sendChatMessage(message: "HEY1");
  //   debugPrint("$a");

  //   for (var p in participants) {
  //     a = await _jitsiMeetPlugin.sendChatMessage(to: p, message: "HEY2");
  //     debugPrint("$a");
  //   }
  // }

  // closeChat() async {
  //   await _jitsiMeetPlugin.closeChat();
  // }

  // retrieveParticipantsInfo() async {
  //   var a = await _jitsiMeetPlugin.retrieveParticipantsInfo();
  //   debugPrint("$a");
  // }
}
