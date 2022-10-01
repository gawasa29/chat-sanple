class User {
  String name;
  String uid;
  String? imagePath;
  //コンストラクタ
  User({
    required this.name,
    required this.uid,
    this.imagePath,
  });
}
