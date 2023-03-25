import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: PreferredSize(
          child: BasicAppbar(title: "Join Room"),
          preferredSize: Size.fromHeight(100)),
      body: Column(
        children: [
          TextInputSystem(
              size: size, icons: Icons.password, hint: 'Room ID(xxx-xxx-xxx)'),
          SizedBox(
            height: 20,
          ),
          BasicButton(click: false, text: "Join Room"),
          SizedBox(
            height: 20,
          ),
          BasicButton(click: false, text: "QR-SCAN"),
        ],
      ),
    );
  }
}
