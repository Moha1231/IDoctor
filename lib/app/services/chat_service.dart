import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatService {
  Future getListChat() async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('Rooms')
          .where('userIds',
              arrayContains: UserService().currentUserFirebase!.uid)
          .get();
      print('list chat : ' + data.docs.length.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  ///TODO need to make it more clean
  Future<types.Room?> getRoomById(String roomId) async {
    try {
      var roomRef = await FirebaseFirestore.instance
          .collection('Rooms')
          .doc(roomId)
          .get();
      var roomDataFirebase = roomRef.data();
      if (roomDataFirebase == null) return null;
      int createdAt =
          (roomDataFirebase['createdAt'] as Timestamp).toDate().millisecond;
      int updatedAt =
          (roomDataFirebase['updatedAt'] as Timestamp).toDate().millisecond;
      List<types.User> listUser = (roomDataFirebase['userIds'] as List<dynamic>)
          .map((e) => types.User(id: e))
          .toList();
      types.Room roomData = types.Room(
          id: roomId,
          type: types.RoomType.direct,
          users: listUser,
          createdAt: createdAt,
          updatedAt: updatedAt,
          name: roomDataFirebase['name'],
          imageUrl: roomDataFirebase['imageUrl']);

      return roomData;
    } catch (e) {
      return Future.error(e);
    }
  }
}
