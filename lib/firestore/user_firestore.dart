import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstanc =
      FirebaseFirestore.instance;
  static final _userCollection = _firebaseFirestoreInstanc.collection("user");

  static Future<String?> createUser() async {
    try {
      final newDoc = await _userCollection.add({
        "name": "nanasi",
        "image_path": "",
      });
      print("アカウント作成完了");
      return newDoc.id;
    } catch (e) {
      print("アカウント作成失敗 ===== $e");
      return null;
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
}
