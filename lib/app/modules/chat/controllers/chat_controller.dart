import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_ui/flutter_chat_ui_types.dart' as types;
import 'package:mime/mime.dart';
import 'package:open_file_plus/open_file_plus.dart';
//import 'package:open_file_safe/open_file_safe.dart';
import 'package:uuid/uuid.dart';

import '../../../services/user_service.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController

  var room = Get.arguments;
  var isAttachmentUploading = false.obs;
  late types.User user;
  var messages = <types.Message>[].obs;
  @override
  void onInit() {
    super.onInit();
    user = types.User(id: UserService().currentUserFirebase!.uid);
  }

  @override
  void onClose() {}
  void handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      messages[index] = updatedMessage;
    });
  }

  void handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      room.id,
    );

    //addMessage(message);
  }

  void addMessage(types.Message message) {
    messages.value.insert(0, message);
  }

  void handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      isAttachmentUploading.value = true;
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          room.id,
        );
        isAttachmentUploading.value = false;
      } finally {
        isAttachmentUploading.value = false;
      }
    }
  }

  void handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      isAttachmentUploading.value = true;
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, room.id);
        isAttachmentUploading.value = false;
      } finally {
        isAttachmentUploading.value = false;
      }
    }
  }
}
