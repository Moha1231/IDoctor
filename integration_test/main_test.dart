import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/services/firebase_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/local_notification_service.dart';
import 'package:hallo_doctor_doctor_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:patrol/patrol.dart';

///Integration Test using Patrol Test, these test are just few example test to make sure the app is working
///To run the test using patrol use this command, but make sure you have install the patroll cli, follow the documentation
///Command : patrol test -t integration_test/main_test.dart
void main() {
  //replace this email and password with your test email and password
  String email = 'elisabeth@gmail.com';
  String password = 'elisabeth';
  setUp(() async {
    await dotenv.load();
    await Firebase.initializeApp();
    LocalNotificationService().initNotification();
    FirebaseChatCore.instance
        .setConfig(const FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
    await GetStorage.init();
    initializeDateFormatting();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  });
  patrolTest('Login Test', ($) async {
    await $.pumpWidgetAndSettle(MainDoctorApp(isUserLogin: false));
    await $(#username).enterText(email);
    await $(#password).enterText(password);
    await $.tester.testTextInput.receiveAction(TextInputAction.done);
    await $(#loginButton).tap(settlePolicy: SettlePolicy.noSettle);
    await $("Welcome Back!").waitUntilExists();
    if (await $.native
        .isPermissionDialogVisible(timeout: Duration(seconds: 10))) {
      // await $.native.grantPermissionWhenInUse();
      print('notification permission pop up');
      await $.native.tap(
        Selector(text: 'Allow'),
      );
    }

    /// click on bottom navigation bar to go
    await $(#calendarIconButton).tap();
    await $(#appointmentIconButton).tap();
    await $(#chatIconButton).tap();
    await $(#profileIconButton).tap();
  });
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load();
//   await Firebase.initializeApp();
//   FirebaseChatCore.instance
//       .setConfig(const FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
//   await GetStorage.init();
//   initializeDateFormatting('en', null);
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);

//   testWidgets('Main Test', (WidgetTester tester) async {
//     // Run app
//     await tester
//         .pumpWidget(MainDoctorApp(isUserLogin: false)); // Create main app
//     await tester.pumpAndSettle(); // Finish animations and scheduled microtasks
//     await tester.pump(Duration(seconds: 2)); // Wait some time

//     // Find username & password text
//     final Finder usernameText = find.byKey(ValueKey('username'));
//     final Finder passwordText = find.byKey(ValueKey('password'));

//     // Ensure there is a login and password field on the initial page
//     expect(usernameText, findsOneWidget);
//     expect(passwordText, findsOneWidget);

//     // Enter text
//     await tester.enterText(usernameText, 'elisabeth@gmail.com');
//     await tester.pumpAndSettle();
//     await tester.enterText(passwordText, 'elisabeth');
//     await tester.testTextInput.receiveAction(TextInputAction.done);
//     await tester.pump(Duration(seconds: 2));
//     await tester.pump();
//     await tester.pumpAndSettle();
//     await tester.pump(Duration(seconds: 2));

//     // Find login button
//     final Finder loginButton = find.byKey(ValueKey('loginButton'));
//     // Tap login button
//     await tester.tap(loginButton, warnIfMissed: true);
//     await tester.pumpAndSettle();
//     await tester.pump(Duration(milliseconds: 200));
//     await tester.tap(loginButton);
//     await tester.pump(Duration(seconds: 20));

//     //find test button
//     expect(find.byKey(ValueKey('testButton')), findsNothing);
//   });
// }
