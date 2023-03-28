// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_ui_find_go/pages/main_menu.dart';
import 'package:ux_ui_find_go/server/Room/crude_room.dart';
import 'package:ux_ui_find_go/server/Room/model_room.dart';
import 'package:ux_ui_find_go/service/room_provider.dart';
import 'package:ux_ui_find_go/service/user_provider.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

import '../maps_page.dart';

class AccepPage extends StatelessWidget {
  AccepPage({super.key, required this.IDroom});
  final String IDroom;
  String stateEvent = "init";
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    RoomProvider roomProvider = context.watch<RoomProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    if (stateEvent == "init") {
      getRoomMembers(roomProvider: roomProvider);
    }
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height * .6,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Join Room",
                style: TextStyle(
                    color: kBackgroundGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                IDroom,
                style: TextStyle(
                    color: kClickButton,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              BasicButton(
                  click: true,
                  text: "Accept",
                  func: () => checkMember(
                      userProvider: userProvider, context: context)),
              BasicButton(
                click: false,
                text: "Cancel",
                func: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenu(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkMember(
      {required UserProvider userProvider, required dynamic context}) async {
    List<RoomMember> res = await CrudeRoom().getRoomsMembers(roomID: IDroom);
    bool noDataInRoom = res
        .where((element) => element.userMember == userProvider.userInfo!.uID)
        .toList()
        .isEmpty;
    Future goMapsPage = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapsPage(
                  IDroom: IDroom,
                )));
    print(res.map((e) => e.userMember).toList());
    print("User: ${userProvider.userInfo!.uID}");
    if (noDataInRoom) {
      int create = await CrudeRoom().postRoomMember(
          roomMember: RoomMember(
              rmId: 0,
              rId: int.parse(IDroom),
              userMember: userProvider.userInfo!.uID,
              rClass: 1,
              status: 1,
              roomBlackList: 0));
      if (create == 200) {
        goMapsPage;
      }
    } else {
      goMapsPage;
    }
  }

  getRoomMembers({required RoomProvider roomProvider}) async {
    List<RoomMember> rm = await CrudeRoom().getRoomsMembers(roomID: IDroom);
    List l = rm.map((e) => e.toJson()).toList();
    debugPrint("db: $l");
    roomProvider.getRoomMember(roomMember: rm);
    stateEvent = "success";
  }
}
