import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message (DocumentSnapshot doc) {
    Map<String, dynamic> _extracted = doc.data() as Map<String, dynamic>;
    friendName = _extracted['friendName'];
    friendId = _extracted['friendId'];
    friendIconUrl = _extracted['friendIconUrl'];
    userId = _extracted['userId'];
    userName = _extracted['userName'];
    iconUrl = _extracted['iconUrl'];
    message = _extracted['message'];
    createdAt = _extracted['createdAt'].toDate();
  }
  DateTime? createdAt;
  String? friendName;
  String? friendId;
  String? friendIconUrl;
  String? userId;
  String? userName;
  String? iconUrl;
  String? message;
}