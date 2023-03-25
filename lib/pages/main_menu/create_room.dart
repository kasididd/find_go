import 'package:flutter/material.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BasicAppbar(title: "Create Room\n     (ส่วนตัว)")),
      body: Column(
        children: [
          TextInputSystem(
              size: size,
              icons: Icons.text_fields,
              hint: 'ขื่อห้อง(ไม่บังครับ)'),
          TextInputSystem(
              size: size, icons: Icons.text_fields, hint: 'รายละเอียด'),
          const SizedBox(
            height: 20,
          ),
          const BasicButton(click: false, text: "Create")
        ],
      ),
    );
  }
}
