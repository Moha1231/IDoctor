import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get onesignalSetupId {
    return dotenv.env['ONE_SIGNAL_SETUP_ID'] ?? '';
  }
}
