// widget ที่สร้างขึ้น

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      required this.size,
      required this.icons,
      required this.hint,
      this.controller});

  final Size size;
  final IconData icons;
  final String hint;
  final TextEditingController? controller;
  // final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: size.width,
      height: 60,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: kFillTextField,
            prefixIcon: Icon(
              icons,
              color: Colors.white,
            ),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
                // กรอบปกติ
                borderSide:
                    const BorderSide(width: 3, color: Colors.transparent),
                borderRadius: BorderRadius.circular(25.0)),
            // กรอบตอนfocus
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

class TextInputDialog extends StatelessWidget {
  const TextInputDialog({
    super.key,
    required this.size,
    required this.icons,
    required this.hint,
  });

  final Size size;
  final IconData icons;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: size.width,
      height: 60,
      child: TextField(
        // textAlign: TextAlign.,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            prefixIcon: Icon(
              icons,
              color: Colors.grey,
            ),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
                // กรอบปกติ
                borderSide: BorderSide(width: 3, color: kBackgroundGreen),
                borderRadius: BorderRadius.circular(25.0)),
            // กรอบตอนfocus
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kBackgroundGreen, width: 2.0),
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

class TextInputSystem extends StatelessWidget {
  const TextInputSystem({
    super.key,
    required this.size,
    required this.icons,
    required this.hint,
  });

  final Size size;
  final IconData icons;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: size.width,
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            prefixIcon: Icon(
              icons,
              color: Colors.grey,
            ),
            label: Text(hint),
            enabledBorder: OutlineInputBorder(
                // กรอบปกติ
                borderSide: BorderSide(width: 3, color: kBackgroundGreen),
                borderRadius: BorderRadius.circular(25.0)),
            // กรอบตอนfocus
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kBackgroundGreen, width: 2.0),
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

class TextAreaInput extends StatelessWidget {
  const TextAreaInput({
    super.key,
    required this.size,
    required this.icons,
    required this.hint,
  });

  final Size size;
  final IconData icons;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: size.width,
      height: 140,
      child: TextField(
        maxLines: 12,
        decoration: InputDecoration(
            filled: true,
            fillColor: kFillTextField,
            prefixIcon: Icon(
              icons,
              color: Colors.white,
            ),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
                // กรอบปกติ
                borderSide:
                    const BorderSide(width: 3, color: Colors.transparent),
                borderRadius: BorderRadius.circular(25.0)),
            // กรอบตอนfocus
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

class TextAreaInputDialog extends StatelessWidget {
  const TextAreaInputDialog({
    super.key,
    required this.size,
    this.icons,
    required this.hint,
  });

  final Size size;
  final icons;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: size.width,
      height: 140,
      child: TextField(
        maxLines: 12,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            prefixIcon: Icon(
              icons == null ? Icons.safety_check : icons,
              color: icons == null ? Colors.grey.shade100 : Colors.grey,
            ),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
                // กรอบปกติ
                borderSide: BorderSide(width: 3, color: kBackgroundGreen),
                borderRadius: BorderRadius.circular(25.0)),
            // กรอบตอนfocus
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kBackgroundGreen, width: 2.0),
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

// ปุ่ม
class BasicButton extends StatelessWidget {
  const BasicButton(
      {super.key, required this.click, required this.text, this.func});
  final bool click;
  final String text;
  final func;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: click ? kClickButton : kBackgroundGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: () {
            func();
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}

class BasicButtonMeduim extends StatelessWidget {
  const BasicButtonMeduim(
      {super.key, required this.click, required this.text, this.func});
  final bool click;
  final String text;
  final func;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: click ? kClickButton : kBackgroundGreen,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: () {
            func();
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
    );
  }
}

class BasicButtonMini extends StatelessWidget {
  const BasicButtonMini(
      {super.key, required this.click, required this.text, this.func});
  final bool click;
  final String text;
  final func;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: click ? kClickButton : kBackgroundGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: () {
            func();
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
    );
  }
}

class SquareButtonM extends StatelessWidget {
  const SquareButtonM({super.key, required this.text, this.func});
  final String text;
  final func;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        func();
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          backgroundColor: kBackgroundGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ButtonB extends StatelessWidget {
  const ButtonB({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: kBackgroundGreen),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ));
  }
}

class OvalButton extends StatelessWidget {
  const OvalButton(
      {super.key, required this.icons, required this.text, this.func});
  final IconData icons;
  final String text;
  final func;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
          onPressed: () {
            func();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: kBackgroundGreen, width: 2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icons,
                color: Colors.orange,
                size: 40,
              ),
              Text(
                text,
                style: TextStyle(color: kBackgroundGreen, fontSize: 16),
              )
            ],
          )),
    );
  }
}

// Alert ที่ทำขึ้นใหม่
class CustomDialog extends StatelessWidget {
  final String title, positiveBtnText, negativeBtnText;
  final GestureTapCallback positiveBtnPressed;
  final IconData icon;
  final Widget content;

  CustomDialog({
    required this.title,
    required this.content,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.positiveBtnPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return SizedBox(
      height: getSize(context).height * 6,
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              // Bottom rectangular box
              margin: const EdgeInsets.only(
                  top: 40), // to push the box half way below circle
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.only(
                  top: 60, left: 20, right: 20), // spacing inside the box
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Text(
                  //   title,
                  //   style: Theme.of(context).textTheme.headline5,
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  content,
                  ButtonBar(
                    buttonMinWidth: 100,
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kBackgroundGreen),
                        child: Text(
                          negativeBtnText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      ElevatedButton(
                        child: Text(
                          positiveBtnText,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 24),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              // Top Circle with icon
              maxRadius: 40.0,
              child: Icon(
                icon,
                size: 40,
                color: kBackgroundGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BasicAppbar extends StatelessWidget {
  const BasicAppbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 35,
                      color: kBackgroundGreen,
                    ),
                  ),
                  Row(
                    children: [
                      // Icon(
                      //   Icons.add_location_alt_rounded,
                      //   color: kClickButton,
                      //   size: 40,
                      // ),
                      Text(title,
                          style: TextStyle(
                              fontSize: 24,
                              color: kBackgroundGreen,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
