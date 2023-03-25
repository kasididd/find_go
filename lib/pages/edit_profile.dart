import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ux_ui_find_go/auth/signup.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool on = true;

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      backgroundColor: kBackgroundGreen,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 650,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 12,
                          )
                        ],
                        color: Colors.white),
                  ),
                  const Text(
                    "Login ด้วย GOOGLE.COM",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextInput(
                      size: size, icons: Icons.text_fields, hint: "Firstname"),
                  TextInput(
                      size: size, icons: Icons.text_fields, hint: "Lastname"),
                  TextInput(
                      size: size, icons: Icons.phone, hint: "Phone Number"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("แสดงเบอร์โทรศัพท์"),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: () => setState(() {
                            on = !on;
                          }),
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(!on ? 12 : 10),
                                  decoration: BoxDecoration(
                                      color:
                                          on ? kBackgroundGreen : kClickButton,
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                              left: Radius.circular(20)),
                                      border: Border.all(
                                          width: 2,
                                          color: on
                                              ? Colors.white
                                              : kClickButton)),
                                  child: const Text("Off")),
                              Container(
                                  padding: EdgeInsets.all(on ? 12 : 10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                              right: Radius.circular(20)),
                                      color:
                                          on ? kClickButton : kBackgroundGreen,
                                      border: Border.all(
                                          width: 2,
                                          color: !on
                                              ? Colors.white
                                              : kBackgroundGreen)),
                                  child: const Text("On")),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  TextAreaInput(
                      size: size, icons: Icons.info, hint: "Comments"),
                ],
              ),
            ),
            SizedBox(
              height: 170,
              width: double.infinity,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    BasicButton(
                        click: true,
                        text: "Edit Profile",
                        func: () => Navigator.pop(context)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BasicButton(
                        click: false,
                        text: "Back",
                        func: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
