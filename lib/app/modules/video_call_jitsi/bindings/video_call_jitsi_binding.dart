import 'package:get/get.dart';

import '../controllers/video_call_jitsi_controller.dart';

class VideoCallJitsiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallJitsiController>(
      () => VideoCallJitsiController(),
    );
  }
}
