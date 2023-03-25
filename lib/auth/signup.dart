import 'package:flutter/material.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kBackgroundGreen,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 670,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Signup",
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
                        ),
                        TextInput(
                            size: size,
                            icons: Icons.text_fields,
                            hint: "Firstname"),
                        TextInput(
                            size: size,
                            icons: Icons.text_fields,
                            hint: "Lastname"),
                        TextInput(
                            size: size,
                            icons: Icons.phone,
                            hint: "Phone Number"),
                        TextInput(
                            size: size, icons: Icons.email, hint: "Email"),
                        TextInput(
                            size: size,
                            icons: Icons.lock,
                            hint: "Password (6 ตัวขึ้นไป)"),
                        TextInput(
                            size: size,
                            icons: Icons.lock,
                            hint: "Confirm Password (6 ตัวขึ้นไป)"),
                      ]),
                ),
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: BasicButton(
                            click: false,
                            text: "Back",
                            func: () => Navigator.pop(context),
                          ),
                        ),
                        BasicButton(
                          click: true,
                          text: "Signup",
                          func: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
