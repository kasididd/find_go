import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ux_ui_find_go/pages/main_menu.dart';
import 'package:ux_ui_find_go/pages/maps_page.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class AccepPage extends StatelessWidget {
  const AccepPage({super.key, required this.IDroom});
  final String IDroom;
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                func: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapsPage(
                              IDroom: IDroom,
                            ))),
              ),
              BasicButton(
                click: false,
                text: "Cancel",
                func: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainMenu(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
