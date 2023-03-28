import 'package:flutter/material.dart';
import 'package:ux_ui_find_go/server/Room/model_room.dart';

class RoomProvider with ChangeNotifier {
  List<RoomMember>? roomMember;
  void getRoomMember({required roomMember}) {
    this.roomMember = roomMember;
  }
}
