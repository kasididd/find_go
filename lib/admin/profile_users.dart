import 'package:flutter/material.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class ProfileUsers extends StatefulWidget {
  const ProfileUsers({super.key});

  @override
  State<ProfileUsers> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<ProfileUsers> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: BasicAppbar(title: "Profile")),
        body: Container(
          margin: const EdgeInsets.all(10),
          decoration:
              BoxDecoration(border: Border.all(width: 4, color: kClickButton)),
          width: size.width,
          height: size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green,
                ),
                width: 100,
                height: 100,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "name users",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kClickButton,
                        ),
                        child: const Icon(
                          Icons.person_search_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                      const Text("Find")
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kClickButton,
                        ),
                        child: const Icon(
                          Icons.push_pin_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                      const Text("Leave")
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
