import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ux_ui_find_go/pages/maps_page.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class InvatePage extends StatefulWidget {
  const InvatePage({super.key});

  @override
  State<InvatePage> createState() => _InvatePageState();
}

class _InvatePageState extends State<InvatePage> {
  // TODO: Invate
  String roomID = "294-294-221", userName = "kasidid";

  final controllerScreenshot = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Screenshot(
      controller: controllerScreenshot,
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: BasicAppbar(title: "Invate")),
        body: SafeArea(
          child: Container(
            height: size.height * .6,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                screenArea(),
                BasicButton(
                  click: false,
                  text: "Share",
                  func: () => shareQR(roomID),
                ),
                // ปุ่มสำหรับคัดลอก
                BasicButton(
                    click: false,
                    text: "Copy",
                    func: () {
                      Clipboard.setData(ClipboardData(text: roomID));
                      // แสดงข้อมูลออกSnackBar
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text("Coppy: $roomID")));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget screenArea() {
    return Container(
      color: Colors.white,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              roomID,
              style: TextStyle(
                  color: kClickButton,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 8,
                    color: kBackgroundGreen,
                  )),
              child: QrImage(
                data: roomID,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            Text(
              "ห้องของ:$userName",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  void shareQR(roomID) async {
    final pic = await controllerScreenshot.captureFromWidget(screenArea());
    final temp = await getApplicationDocumentsDirectory();
    final picPath = "${temp.path}/invate.png";
    await File(picPath).writeAsBytes(pic);
    Share.shareFiles([picPath]);
  }
}
