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
                              "data:image/png;base64,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"),
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
