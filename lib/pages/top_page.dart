import 'package:chat_sanple/firestore/room_firestore.dart';
import 'package:chat_sanple/pages/setting_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/talk_room.dart';
import '../model/user.dart';
import 'talk_room_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> userList = [
    User(
      name: '田中',
      uid: "abc",
      imagePath:
          "https://www.google.com/search?q=udemy&rlz=1C5CHFA_enJP1017JP1017&sxsrf=ALiCzsYb5OOxw0nhMl3TgkE_X1gTjvLbdA:1663526366784&source=lnms&tbm=isch&sa=X&ved=2ahUKEwi6qarR_p76AhUK_WEKHdFWCX4Q_AUoA3oECAIQBQ&biw=1920&bih=859&dpr=1#imgrc=353mCegWxiYWpM",
    ),
    User(
      name: '佐藤',
      uid: "abc",
      imagePath:
          "https://www.google.com/search?q=udemy&rlz=1C5CHFA_enJP1017JP1017&sxsrf=ALiCzsYb5OOxw0nhMl3TgkE_X1gTjvLbdA:1663526366784&source=lnms&tbm=isch&sa=X&ved=2ahUKEwi6qarR_p76AhUK_WEKHdFWCX4Q_AUoA3oECAIQBQ&biw=1920&bih=859&dpr=1#imgrc=353mCegWxiYWpM",
    ),
    User(
      name: '鈴木',
      uid: "abc",
      imagePath:
          "https://www.google.com/search?q=udemy&rlz=1C5CHFA_enJP1017JP1017&sxsrf=ALiCzsYb5OOxw0nhMl3TgkE_X1gTjvLbdA:1663526366784&source=lnms&tbm=isch&sa=X&ved=2ahUKEwi6qarR_p76AhUK_WEKHdFWCX4Q_AUoA3oECAIQBQ&biw=1920&bih=859&dpr=1#imgrc=353mCegWxiYWpM",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingProfilePage()),
                );
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: RoomFirestore.joindRoomSnapshot,
          //streamSnapshotとfutereSnapshotはややこしくなるから変数名変えてるだけ本来はsnapshotだけ。
          builder: (context, streamSnapshot) {
            //データがあったらの処理
            if (streamSnapshot.hasData) {
              return FutureBuilder<List<TalkRoom>?>(
                  future: RoomFirestore.fetchjoinedRooms(streamSnapshot.data!),
                  builder: (context, futereSnapshot) {
                    if (futereSnapshot.hasData) {
                      List<TalkRoom> talkRooms = futereSnapshot.data!;
                      return ListView.builder(
                        itemCount: talkRooms.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TalkRoomPage(
                                        talkRooms[index].talkUser.name)),
                              );
                            },
                            child: SizedBox(
                              height: 70,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: talkRooms[index]
                                                  .talkUser
                                                  .imagePath ==
                                              null
                                          ? null
                                          : const NetworkImage(
                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKZ1ju2tP1F8EtCeSC3PskBLWCseTn4_MtXw&usqp=CAU"),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        talkRooms[index].talkUser.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(talkRooms[index].lastMessege ?? ''),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Text("トークの取得に失敗しました");
                    }
                  });
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
