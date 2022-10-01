import 'package:chat_sanple/model/user.dart';

class TalkRoom {
  String roomId;
  User talkUser;
  String? lastMessege;

  TalkRoom({required this.roomId, required this.talkUser, this.lastMessege});
}
