import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:ux_ui_find_go/pages/edit_profile.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class RoleSettings extends StatefulWidget {
  const RoleSettings({super.key});

  @override
  State<RoleSettings> createState() => _RoleSettingsState();
}

class _RoleSettingsState extends State<RoleSettings> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BasicAppbar(
            title: "ตั้งค่าสิทธ์(Role)",
          )),
      body: SizedBox(
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text("${index + 1} ชื่อผู้ใช้"),
                    subtitle: Text("Loginด้วย(สิทธ์)"),
                    trailing: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        customButton: Icon(Icons.settings),
                        customItemsHeights: [
                          ...List<double>.filled(
                              MenuItems.firstItems.length, 48),
                          8,
                        ],
                        items: [
                          ...MenuItems.firstItems.map(
                            (item) => DropdownMenuItem<MenuItem>(
                              value: item,
                              child: MenuItems.buildItem(item),
                            ),
                          ),
                          const DropdownMenuItem<Divider>(
                              enabled: false, child: Divider()),
                        ],
                        onChanged: (value) {
                          MenuItems.onChanged(context, value as MenuItem);
                        },
                        itemHeight: 48,
                        itemPadding: const EdgeInsets.only(left: 16, right: 16),
                        dropdownWidth: 200,
                        dropdownPadding:
                            const EdgeInsets.symmetric(vertical: 6),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        dropdownElevation: 8,
                        offset: const Offset(0, 8),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, settings];

  static const home =
      MenuItem(text: 'Admin', icon: Icons.admin_panel_settings_rounded);
  static const share = MenuItem(text: 'Assist', icon: Icons.assignment_add);
  static const settings = MenuItem(text: 'Users', icon: Icons.person);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoleEdit(),
              ));
        }
        //Do something
        break;
      case MenuItems.settings:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
    }
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class RoleEdit extends StatefulWidget {
  const RoleEdit({super.key});

  @override
  State<RoleEdit> createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<RoleEdit> {
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
