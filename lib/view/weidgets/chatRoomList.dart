import 'package:chat_re/objects/chatroom.dart';
import 'package:chat_re/view/pushPage/chatRoomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///dammy url
String toriUrl =
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.sapporo-park.or.jp%2Fasahiyama%2F%3Fpage_id%3D2386&psig=AOvVaw1TUfrLWiXbaBsdZh8CDs69&ust=1631771267685000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCLCXu-ijgPMCFQAAAAAdAAAAABAD';

Widget chatRoomList(
    {required BuildContext context,
    required List<ChatRoom> chatRoomList,
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
                      friendId: chatRoomList[index].friendUid!,
                      friendName: chatRoomList[index].friendName!,
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
                    chatRoomList[index].friendIconUrl == ''
                        ? toriUrl
                        : chatRoomList[index].friendIconUrl!),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 8.0),
                  child: Text(chatRoomList[index].friendName!),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                  child: Text(chatRoomList[index].message!),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
