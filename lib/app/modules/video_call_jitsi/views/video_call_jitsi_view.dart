import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/video_call_jitsi_controller.dart';

class VideoCallJitsiView extends GetView<VideoCallJitsiController> {
  const VideoCallJitsiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call With Jitsi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text('We have send invitation to Client'),
          Text(
              'Please open your Jitsi app and create a room with the following room name:'),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Room Name : ' + controller.timeSlot.timeSlotId.toString()),
                IconButton(
                    onPressed: () {
                      controller.copyRoomName();
                    },
                    icon: Icon(Icons.copy))
              ],
            ),
          ),
          TextButton(
            onPressed: controller.openJitsi,
            child: const Text("Join"),
          ),
        ]),
      ),
    );
  }
}
