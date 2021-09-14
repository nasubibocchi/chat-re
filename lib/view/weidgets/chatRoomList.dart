import 'package:chat_re/objects/chatroom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget chatRoomList(
    {required BuildContext context,
    required List<ChatRoom> chatRoomList,
    required int index}) {
  return Container(
    height: 10.0,
    width: 30.0,
    child: InkWell(
      //TODO: カードをタップしたらチャットルームに移動する
      onTap: (){},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  child: Text(chatRoomList[index].friendName!),
                ),
                //TODO: ダミー
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                  child: Text('ダミー'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
