import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  ChatRoom (DocumentSnapshot doc) {
    Map<String, dynamic> _extracted = doc.data() as Map<String, dynamic>;
    friendName = _extracted['friendName'];
    friendUid = _extracted['friendId'];
    friendIconUrl = _extracted['friendIconUrl'];
    message = _extracted['message'];
  }
  String? friendName;
  String? friendUid;
  String? friendIconUrl;
  String? message;
}