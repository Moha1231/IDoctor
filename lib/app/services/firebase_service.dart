import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/utils.dart';
import 'package:hallo_doctor_doctor_app/app/collection/firebase_collection.dart';
import 'package:hallo_doctor_doctor_app/app/models/user_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

import 'package:path/path.dart';

class FirebaseService {
  Future<bool> checkUserAlreadyLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      printInfo(info: 'User Uid : ${auth.currentUser!.uid}');
      return true;
    } else {
      printInfo(info: 'User not login yet');
      return false;
    }
  }

  Future userSetup(User user, String displayName) async {
    String uid = user.uid.toString();
    UserModel newUser = UserModel(
        email: user.email,
        displayName: displayName,
        lastLogin: user.metadata.lastSignInTime,
        createdAt: user.metadata.creationTime,
        userId: uid,
        role: 'doctor');
    await FirebaseCollection().userCol.doc(uid).set(newUser);
    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(uid)
    //     .set(newUser.toJson());
    print('newUser : ' + newUser.toJson().toString());
  }

  Future<String> uploadImage(File filePath) async {
    try {
      String fileName = basename(filePath.path);
      var ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
      final result = await ref.putFile(File(filePath.path));
      final fileUrl = await result.ref.getDownloadURL();
      return fileUrl;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
