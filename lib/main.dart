import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/services/local_notification_service.dart';
import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';

import 'app/routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/services/firebase_service.dart';
import 'app/utils/localization.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
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

class MainDoctorApp extends StatelessWidget {
  MainDoctorApp({super.key, required this.isUserLogin});
  final bool isUserLogin;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hallo Doctor Doctor App",
        initialRoute: isUserLogin ? AppPages.dashboard : AppPages.login,
        getPages: AppPages.routes,
        builder: EasyLoading.init(),
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
        ],
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              elevation: 2,
              color: Colors.white,
              iconTheme: IconThemeData(
                  color: Colors
                      .black), // set backbutton color here which will reflect in all screens.
            ),
            useMaterial3: true),
        locale: LocalizationService.locale,
        translations: LocalizationService());
  }
}
