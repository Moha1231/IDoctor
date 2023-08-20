import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/collection/firebase_collection.dart';
import 'package:hallo_doctor_doctor_app/app/models/user_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/firebase_service.dart';

import 'auth_service.dart';

class UserService {
  ///this user representing userdata in firestore database, you can modify this user, base on your need
  ///such adding more property like age, gender, nationality, etc
  static UserModel? _userModel;

  /// set new user data
  set user(UserModel userModel) => UserService._userModel = userModel;

  /// get current user data
  UserModel get user {
    if (UserService._userModel == null) {
      throw Exception('User is null');
    } else {
      return UserService._userModel!;
    }
  }

  ///user firebase, you cannot add another property to this user, use userModel to add another property
  ///other property to use, such age, gender, etc,
  ///this user belong to firebase, and only few property like email, password, uid
  static User? _userFirebase;

  set currentUserFirebase(User? user) => UserService._userFirebase = user;

  User? get currentUserFirebase {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return auth.currentUser;
    } else {
      print('User Null');
      return null;
    }
  }

  Future<String> getPhotoUrl() async {
    String? profilePic;
    try {
      profilePic = currentUserFirebase?.photoURL ?? "";
    } catch (e) {
      profilePic = '';
    }
    return profilePic;
  }

  Future<UserModel?> getUserModel() async {
    try {
      if (currentUserFirebase == null) {
        throw Exception('user is null');
      }
      var user = await FirebaseCollection()
          .userCol
          .doc(currentUserFirebase!.uid)
          .get();
      if (!user.exists) {
        printError(
            info:
                'User data from firestore not found, could be deleted or not saved yet');
        return null;
      }
      this.user = user.data()!;
      printInfo(info: 'User id : ${this.user.userId}');
      return user.data();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String?> getDoctorId() async {
    try {
      var docRef = await FirebaseCollection()
          .userCol
          .doc(currentUserFirebase!.uid)
          .get();
      if (docRef.data()?.doctorId != null) {
        return docRef.data()?.doctorId!;
      } else {
        return null;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  /// Change password
  Future changePassword(String currentPassword, String newPassword) async {
    try {
      bool validatePassword =
          await AuthService().verifyPassword(currentPassword);
      if (validatePassword) {
        currentUserFirebase!.updatePassword(newPassword);
      }
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  /// update profile pic from local storage
  Future<String> updatePhoto(File filePath) async {
    try {
      String url = await FirebaseService().uploadImage(filePath);
      currentUserFirebase!.updatePhotoURL(url);
      return url;
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  /// Update current user/local user profile url
  Future setPictureUrl(String url) async {
    try {
      currentUserFirebase!.updatePhotoURL(url);
    } catch (err) {
      Future.error(err.toString());
    }
  }

  Future updateEmail(String email) async {
    try {
      currentUserFirebase!.updateEmail(email);
    } catch (err) {
      return Future.error(err);
    }
  }

  Future setDoctorId(String doctorId) async {
    try {
      await FirebaseCollection()
          .userCol
          .doc(currentUserFirebase!.uid)
          .update({'doctorId': doctorId.toString()});
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future updateUserToken(String? token) async {
    try {
      List<String> newListToken;
      if (token == null) return printError(info: 'firebase token is null');
      if (user.token == null) {
        newListToken = [token];
        await _updateTokenFirebase(newListToken);
        return;
      } else {
        newListToken = [...?user.token, token];
        if (user.token!.contains(token)) {
          return printInfo(
              info: 'this token already exist, not update the token');
        } else {
          await _updateTokenFirebase(newListToken);
          return;
        }
      }
    } catch (e) {
      Future.error(e.toString());
    }
  }

  Future<bool> checkIfUserExist() async {
    var userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUserFirebase!.uid)
        .get();
    if (userSnapshot.exists) return true;
    return false;
  }

  ///Delete specific notification token from this user, in database
  Future removeUserToken(String token) async {
    try {
      await FirebaseCollection().userCol.doc(currentUserFirebase!.uid).update({
        'token': FieldValue.arrayRemove([token])
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteAccountPermanently() async {
    try {
      var callable = FirebaseFunctions.instance.httpsCallable('deleteUser');
      await callable({'userId': currentUserFirebase!.uid});
    } catch (e) {
      return Future.error(e);
    }
  }

  Future _updateTokenFirebase(List<String> listToken) async {
    try {
      await FirebaseCollection()
          .userCol
          .doc(currentUserFirebase!.uid)
          .update({'token': FieldValue.arrayUnion(listToken)});
      user.token = listToken;
    } catch (e) {
      throw Future.error(e.toString());
    }
  }
}
