import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';

class VideoCallService {
  var database = FirebaseDatabase.instance.ref();

  Future<String> getAgoraToken(String roomName) async {
    var callable = FirebaseFunctions.instance.httpsCallable('generateToken');
    final results =
        await callable({'channelName': roomName, 'role': 'publisher'});
    var clientSecret = results.data;
    return clientSecret;
  }

  Future removeRoom(String roomName) async {
    try {
      await database.child('room/' + roomName).remove();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
