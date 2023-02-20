import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/local_notification_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/notification_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

import 'firebase_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  Future login(String username, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      UserService().currentUserFirebase = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future regiterNewUser(String username, String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserService().currentUserFirebase = result.user;
      await UserService().currentUserFirebase!.updateDisplayName(username);
      await FirebaseService().userSetup(result.user!, username);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    } on SocketException catch (e) {
      return Future.error(e.message);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  /// for checking user password, ex change password, withdraw balance need passsword
  Future<bool> verifyPassword(String password) async {
    try {
      var firebaseUser = _auth.currentUser!;
      var authCredential = EmailAuthProvider.credential(
          email: firebaseUser.email!, password: password);
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredential);
      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future resetPassword(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //check whether user is already set his the doctor detail or not
  Future<bool> checkDoctorDetail() async {
    try {
      String? doctorId = await UserService().getDoctorId();
      if (doctorId != null) return true;
      return false;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future logout() async {
    GetStorage().erase();
    await LocalNotificationService().removeToken();
    _auth.signOut();
    DoctorService.doctor = null;
  }
}
