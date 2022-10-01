import 'package:chat_sanple/utils/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';
import 'room_firestore.dart';

class UserFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstanc =
      FirebaseFirestore.instance;
  static final _userCollection = _firebaseFirestoreInstanc.collection("user");

  static Future<String?> insertNewAccount() async {
    try {
      final newDoc = await _userCollection.add({
        "name": "名無し",
        "image_path": "",
      });
      print("アカウント作成完了");
      return newDoc.id;
    } catch (e) {
      print("アカウント作成失敗 ===== $e");
      return null;
    }
  }

  static Future<void> createUser() async {
    final myUid = await UserFirestore.insertNewAccount();
    //myUidがString?型なのでifの記述が必要
    if (myUid != null) {
      await RoomFirestore.createRoom(myUid);
      await SharedPrefs.setUid(myUid);
    }
  }

  static Future<List<QueryDocumentSnapshot>?> fetchUsers() async {
    try {
      final snapshot = await _userCollection.get();
      //.docsはget()したドキュメントをlistにする。forEach関数は普通にlistの関数
      snapshot.docs.forEach((doc) {
        print("ドキュメントID : ${doc.id} ----- 名前: ${doc.data()["name"]}");
      });
      return snapshot.docs;
    } catch (e) {
      print("ユーザー情報の取得失敗 ===== $e");
    }
    return null;
  }

//引数で入れたユーザーの情報をfirestoreで持ってくる
  static Future<User?> fetchProfile(String uid) async {
    try {
      final snapshot = await _userCollection.doc(uid).get();
      User user = User(name: snapshot.data()!["name"], uid: uid);
      return user;
    } catch (e) {
      print("ユーザー情報の所得失敗 ----- $e");
      return null;
    }
  }
}
