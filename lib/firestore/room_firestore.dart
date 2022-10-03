import 'package:chat_sanple/firestore/user_firestore.dart';
import 'package:chat_sanple/model/talk_room.dart';
import 'package:chat_sanple/utils/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class RoomFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstanc =
      FirebaseFirestore.instance;
  static final _roomCollection = _firebaseFirestoreInstanc.collection("room");
  //roomコレクションのjoined_user_idsフィールドの自分のUIDとと同じ値のSnapshotを得る。
  static final joindRoomSnapshot = _roomCollection
      .where("joined_user_ids",
          arrayContains: SharedPrefs
              .fetchUid()) //whereは特定の条件で抽出するクエリを指定できる。arrayContainsは配列内に指定した要素を含む場合だけ取得する.
      .snapshots();

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
  static Future<List<TalkRoom>?> fetchjoinedRooms(
      QuerySnapshot snapshot) async {
    try {
      String myUid = SharedPrefs.fetchUid()!;
      List<TalkRoom> talkRooms = [];
//docsは_JsonQuerySnapshotのList型のdocsプロパティー。(QuerySnapshotは複数のドキュメントのデータを持つスナップショットです。)
      for (var doc in snapshot.docs) {
        //firestoreに保存されているデータを取得したいときは、生成したSnapshotのdata()メソッドを呼びます。
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> userIds = data['joined_user_ids'];
        late String talkUserUid;
        for (var id in userIds) {
          if (id == myUid) continue;
          talkUserUid = id;
        }
        User? talkUser = await UserFirestore.fetchProfile(talkUserUid);
        if (talkUser == null) return null;
        final talkRoom = TalkRoom(
            roomId: doc.id,
            talkUser: talkUser,
            lastMessege: data['last_message']);
        talkRooms.add(talkRoom);
      }
      print('自分が参加しているルームの数${talkRooms.length}');
      return talkRooms;
    } catch (e) {
      print('参加しているルームの取得失敗');
      return null;
    }
  }

  static Stream<QuerySnapshot> fetchMessageSnapshot(String roomId) {
    return _roomCollection
        .doc(roomId)
        .collection('message')
        //orderBy（特定の条件で並べ替える）チャットのメッセージを時間ごとで表示したいから並び替えるorderByを使っている。
        .orderBy('send_time', descending: true)
        .snapshots();
  }
}
