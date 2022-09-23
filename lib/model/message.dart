class Message {
  String message;
  //私が送ったかどうか
  bool isMe;
  DateTime sendTime;
  Message({required this.message, required this.isMe, required this.sendTime});
}
