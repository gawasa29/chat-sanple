import 'package:chat_sanple/firestore/user_firestore.dart';
import 'package:chat_sanple/pages/top_page.dart';
import 'package:chat_sanple/utils/shared_prefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
//flutterfire_cliで追加されたfirebase_options.dartのためにいる。
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs.setPrefsInstance();
  String? uid = SharedPrefs.fetchUid();
  //端末に情報があった場合ここの分岐に入らない。
  if (uid == null) await UserFirestore.createUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TopPage(),
    );
  }
}
