import 'package:chat_sanple/pages/setting_profile_page.dart';
import 'package:flutter/material.dart';

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
      lastMessage: "おはようございます",
    ),
    User(
      name: '佐藤',
      uid: "abc",
      imagePath:
          "https://www.google.com/search?q=udemy&rlz=1C5CHFA_enJP1017JP1017&sxsrf=ALiCzsYb5OOxw0nhMl3TgkE_X1gTjvLbdA:1663526366784&source=lnms&tbm=isch&sa=X&ved=2ahUKEwi6qarR_p76AhUK_WEKHdFWCX4Q_AUoA3oECAIQBQ&biw=1920&bih=859&dpr=1#imgrc=353mCegWxiYWpM",
      lastMessage: "こんにちは",
    ),
    User(
      name: '鈴木',
      uid: "abc",
      imagePath:
          "https://www.google.com/search?q=udemy&rlz=1C5CHFA_enJP1017JP1017&sxsrf=ALiCzsYb5OOxw0nhMl3TgkE_X1gTjvLbdA:1663526366784&source=lnms&tbm=isch&sa=X&ved=2ahUKEwi6qarR_p76AhUK_WEKHdFWCX4Q_AUoA3oECAIQBQ&biw=1920&bih=859&dpr=1#imgrc=353mCegWxiYWpM",
      lastMessage: "こんばんは",
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
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TalkRoomPage(userList[index].name)),
              );
            },
            child: SizedBox(
              height: 70,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: userList[index].imagePath == null
                          ? null
                          : const NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKZ1ju2tP1F8EtCeSC3PskBLWCseTn4_MtXw&usqp=CAU"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userList[index].name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(userList[index].lastMessage),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
