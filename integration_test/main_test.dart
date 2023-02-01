import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/services/firebase_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/notification_service.dart';
import 'package:hallo_doctor_doctor_app/app/utils/environment.dart';
import 'package:hallo_doctor_doctor_app/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

///Text login & Register app, make sure the app can still run
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  FirebaseChatCore.instance
      .setConfig(const FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  await GetStorage.init();
  initializeDateFormatting('en', null);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  testWidgets('Main Test', (WidgetTester tester) async {
    // Run app
    await tester
        .pumpWidget(MainDoctorApp(isUserLogin: false)); // Create main app
    await tester.pumpAndSettle(); // Finish animations and scheduled microtasks
    await tester.pump(Duration(seconds: 2)); // Wait some time

    // Find username & password text
    final Finder usernameText = find.byKey(ValueKey('username'));
    final Finder passwordText = find.byKey(ValueKey('password'));

    // Ensure there is a login and password field on the initial page
    expect(usernameText, findsOneWidget);
    expect(passwordText, findsOneWidget);

    // Enter text
    await tester.enterText(usernameText, 'elisabeth@gmail.com');
    await tester.pumpAndSettle();
    await tester.enterText(passwordText, 'elisabeth');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(Duration(seconds: 2));
    await tester.pump();
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));

    // Find login button
    final Finder loginButton = find.byKey(ValueKey('loginButton'));
    // Tap login button
    await tester.tap(loginButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 20));
    //find test button
    expect(find.byKey(ValueKey('testButton')), findsNothing);
  });
}
