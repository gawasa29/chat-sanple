import 'package:chat_sanple/firestore/room_firestore.dart';
import 'package:chat_sanple/pages/setting_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/talk_room.dart';
import 'talk_room_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
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
                              print(talkRooms[index].roomId);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TalkRoomPage(talkRooms[index])),
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
                      return const Text("トークの取得に失敗しました");
                    }
                  });
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
