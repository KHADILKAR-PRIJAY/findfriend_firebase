import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future getUser(String userId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: userId)
        .get();
  }

  uploadUserInfo(userMap, docName) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(docName)
        .set(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  uploadUserInfoCustom() {
    FirebaseFirestore.instance
        .collection('users')
        .doc('eIUke9ekgLwwGL8srres')
        .set({'name': 'shivam'});
  }

  updateUserInfo(String userid, String fieldValue, String fieldKey) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .update({fieldKey: fieldValue});
  }

  createChatRoom(String chatroomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatroomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessage(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future getConversationMessage(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future getChatRooms(String userId) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .where('users', arrayContains: userId)
        .snapshots();
  }
}
