import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/services/firebase_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/local_notification_service.dart';
import 'package:hallo_doctor_doctor_app/main.dart';

import '../app/utils/constants.dart';
import 'package:intl/date_symbol_data_local.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  LocalNotificationService().initNotification();
  FirebaseChatCore.instance
      .setConfig(const FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  await GetStorage.init();
  FirebaseAuth.instance.setLanguageCode(locale);
  bool isUserLogin = await FirebaseService().checkUserAlreadyLogin();
  initializeDateFormatting();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MainDoctorApp(
    isUserLogin: isUserLogin,
  ));
}
