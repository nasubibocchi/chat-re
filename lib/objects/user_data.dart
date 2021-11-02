import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  UserData (DocumentSnapshot doc) {
    Map<String, dynamic> _extracted = doc.data() as Map<String, dynamic>;
    userName = _extracted['userName'];
    userId = _extracted['userId'];
    iconUrl = _extracted['iconUrl'];
    signInAt = _extracted['signInAt'].toDate();
  }
  String? userName;
  String? userId;
  String? iconUrl;
  DateTime? signInAt;
}