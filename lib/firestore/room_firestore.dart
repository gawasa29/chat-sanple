import 'package:chat_sanple/firestore/user_firestore.dart';
import 'package:chat_sanple/model/talk_room.dart';
import 'package:chat_sanple/utils/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class RoomFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstanc =
      FirebaseFirestore.instance;
  static final _roomCollection = _firebaseFirestoreInstanc.collection("room");

  static Future<void> createRoom(String myUid) async {
    try {
      final docs = await UserFirestore.fetchUsers();
      if (docs == null) return;
      docs.forEach((doc) async {
        if (doc.id == myUid) return;
        await _roomCollection.add({
          "joined_user_ids": [doc.id, myUid],
          "created_time": Timestamp.now()
        });
      });
    } catch (e) {
      print("ルームの作成失敗 ==== $e");
    }
  }

//自分が入っているルームを取得
  static Future<void> fetchjoinedRooms() async {
    try {
      String myUid = SharedPrefs.fetchUid()!;
      List<TalkRoom> talkRooms = [];
      //roomコレクションのjoined_user_idsフィールドのmyUid変数と同じ値の_JsonQuerySnapshotを得る。
      final snapshot = await _roomCollection
          .where("joined_user_ids",
              arrayContains:
                  myUid) //whereは特定の条件で抽出するクエリを指定できる。arrayContainsは配列内に指定した要素を含む場合だけ取得する.
          .get();
//docsは_JsonQuerySnapshotのList型のdocsプロパティー。(QuerySnapshotは複数のドキュメントのデータを持つスナップショットです。)
      for (var doc in snapshot.docs) {
        //firestoreに保存されているデータを取得したいときは、生成したSnapshotのdata()メソッドを呼びます。
        List<dynamic> userIds = doc.data()['joined_user_ids'];
        late String talkUserUid;
        for (var id in userIds) {
          if (id == myUid) continue;
          talkUserUid = id;
        }
        User? talkUser = await UserFirestore.fetchProfile(talkUserUid);
        if (talkUser == null) return;
        final talkRoom = TalkRoom(
            roomId: doc.id,
            talkUser: talkUser,
            lastMessege: doc.data()['last_message']);

        talkRooms.add(talkRoom);
      }
      print('自分が参加しているルームの数${talkRooms.length}');
    } catch (e) {
      print('参加しているルームの取得失敗');
    }
  }
}
