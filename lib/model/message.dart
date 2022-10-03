import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String message;
  //私が送ったかどうか
  bool isMe;
  Timestamp sendTime;
  Message({required this.message, required this.isMe, required this.sendTime});
}
