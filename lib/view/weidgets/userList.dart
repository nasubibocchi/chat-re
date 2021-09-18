import 'package:chat_re/objects/userData.dart';
import 'package:chat_re/view/pushPage/chatRoomPage.dart';
import 'package:chat_re/view/weidgets/chatRoomList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget userList(
    {required BuildContext context,
    required List<UserData> userList,
    required int index}) {
  return Container(
    height: 130.0,
    width: 500.0,
    child: InkWell(
      /// カードをタップしたらチャットルームに移動する
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatRoomPage(
                      friendId: userList[index].userId!,
                      friendName: userList[index].userName!,
                    )));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    userList[index].iconUrl! == ''
                        ? toriUrl
                        : userList[index].iconUrl!),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 8.0),
                  child: Text(userList[index].userName!),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
