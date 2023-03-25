import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class SystemSettings extends StatefulWidget {
  const SystemSettings({super.key});

  @override
  State<SystemSettings> createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {
  DateTime chosenDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: BasicAppbar(title: "จัดการระบบ(System)"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("ตั้งค่าเมนู"),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "ส่วนตัว",
                          style: TextStyle(
                              color: kBackgroundGreen,
                              fontWeight: FontWeight.w700),
                        ),
                        BasicButtonMini(click: true, text: "On"),
                        BasicButtonMini(click: false, text: "Off"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      color: Colors.grey.shade300,
                      width: double.infinity,
                      height: 2,
                    ),
                  ),
                  Text("ตั้งค่าเวอร์ชั้นแอพฯ"),
                  TextInputSystem(
                      size: size, icons: Icons.shield_sharp, hint: "App name"),
                  TextInputSystem(
                      size: size, icons: Icons.shield_sharp, hint: "Version"),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "ประเภท",
                          style: TextStyle(
                              color: kBackgroundGreen,
                              fontWeight: FontWeight.w700),
                        ),
                        BasicButtonMini(click: true, text: "Full"),
                        BasicButtonMini(click: false, text: "Trial  "),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  0.25,
                              color: Colors.white,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.dateAndTime,
                                onDateTimeChanged: (value) {
                                  setState(() {
                                    chosenDateTime = value;
                                  });
                                  print(DateFormat('yyy-MM-dd-hh:mm:ss')
                                      .format(chosenDateTime));
                                },
                                initialDateTime: DateTime.now(),
                                minimumYear: 2000,
                                maximumYear: 3000,
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: kBackgroundGreen,
                            size: 30,
                          ),
                          Text(
                            DateFormat('yyy-MM-dd-hh:mm:ss')
                                .format(chosenDateTime)
                                .toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  BasicButtonMeduim(click: true, text: "แก้ไข"),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      color: Colors.grey.shade300,
                      width: double.infinity,
                      height: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
