import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ux_ui_find_go/auth/login.dart';
import 'package:ux_ui_find_go/pages/edit_profile.dart';
import 'package:ux_ui_find_go/pages/main_menu/create_room.dart';
import 'package:ux_ui_find_go/pages/main_menu/qr_scan.dart';
import 'package:ux_ui_find_go/pages/settings/category_settings.dart';
import 'package:ux_ui_find_go/pages/settings/role_settings.dart';
import 'package:ux_ui_find_go/pages/settings/system_settings.dart';
import 'package:ux_ui_find_go/pages/stl/accep_page.dart';
import 'package:ux_ui_find_go/server/Room/crude_room.dart';
import 'package:ux_ui_find_go/server/Room/model_room.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

import '../service/user_provider.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<Room> roomList = [
    // {'name': 'nameRoom', 'IDroom': '234-152-552', 'visible': true},
    // {'name': 'nameRoom', 'IDroom': '524-152-552', 'visible': true}
  ];
  String stateEvent = "init";

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    // รับข้อมูลห้อง
    if (stateEvent == "init") {
      getRoomData();
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const NavBar(),
            // รูปผู้ใช้
            const UserProfile(),
            // 3 floors buttons
            AllButton(size: size),
            // รายการห้อง
            roomExpaned(context)
          ],
        ),
      )),
    );
  }

  Expanded roomExpaned(BuildContext context) {
    return Expanded(
        child: stateEvent == "loading room"
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : stateEvent == "no room"
                ? Center(
                    child: OutlinedButton(
                        onPressed: () => getRoomData(),
                        child: const Text("ไม่มีห้อง...  คลิก เพิ่อรีเฟรช")),
                  )
                : stateEvent == "Error"
                    ? const Center(
                        child: Text("มีข้อผิดพลาด ลองปิดแอพเข้าใหม่"),
                      )
                    : ReorderableListView(
                        onReorder: (oldIndex, newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex--;
                          }
                          setState(() {
                            final item = roomList.removeAt(oldIndex);
                            roomList.insert(newIndex, item);
                          });
                        },
                        children: [
                            for (int index = 0;
                                index < roomList.length;
                                index++)
                              Card(
                                key: ValueKey(index),
                                color: roomList[index].visible.isOdd
                                    ? Colors.grey.shade100
                                    : Colors.grey.shade400,
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () => !roomList[index].visible.isOdd
                                      ? null
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AccepPage(
                                                IDroom: roomList[index]
                                                    .rID
                                                    .toString()),
                                          )),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.lock,
                                      color: Colors.amber,
                                    ),
                                    title: Text(roomList[index].rName),
                                    subtitle:
                                        Text(roomList[index].rID.toString()),
                                    trailing: IconButton(
                                      onPressed: () => setState(() {
                                        // ทำให้มองไม่เห็นห้องโดยข้อมูลนี้ควรมีTableแยก
                                        roomList[index] = roomList[index];
                                      }),
                                      icon: Icon(
                                        roomList[index].visible.isOdd
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: kBackgroundGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ]));
  }

  void getRoomData() async {
    setState(() {
      stateEvent = "loading room";
    });
    Future.delayed(const Duration(seconds: 10)).then((value) {
      setState(() {
        if (stateEvent == "loading room") {
          stateEvent = "Error";
        }
      });
      return;
    });
    List<Room> result = await CrudeRoom().getRooms();
    if (result.isEmpty) {
      setState(() {
        stateEvent = "no room";
      });
      return;
    } else {
      setState(() {
        roomList = result;
        stateEvent = "success";
      });
    }
  }
}

class AllButton extends StatelessWidget {
  const AllButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SquareButtonM(
                text: "Edit Profile",
                func: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ))),
            const SizedBox(
              width: 10,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: kBackgroundGreen,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "⚙️ Settings",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                customItemsHeights: [
                  ...List<double>.filled(MenuItems.firstItems.length, 48),
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
                dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                dropdownElevation: 8,
                offset: const Offset(0, 8),
              ),
            ),
          ],
        ),
        // ตัวกัน
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            color: Colors.grey,
            width: size.width * .8,
            height: 2,
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              SizedBox(
                width: 10,
              ),
              ButtonB(
                text: "Private Room",
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: ButtonB(
                  text: "Private Room",
                ),
              ),
              ButtonB(
                text: "Private Room",
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OvalButton(
                func: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateRoom(),
                    )),
                icons: Icons.add,
                text: "Create Room",
              ),
              OvalButton(
                func: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRscan(),
                    )),
                icons: Icons.login,
                text: "Join Room\n& QR Scan",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Column(
      children: [
        ClipOval(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.green[800],
            child: Center(
              child: userProvider.userInfo!.uImage == "None"
                  ? Text(
                      userProvider.userInfo!.uName[0],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    )
                  : Image.network(userProvider.userInfo!.uImage),
            ),
          ),
        ),

        // ชื่อ
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            userProvider.userInfo!.uName,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => launchUrl(
                Uri.parse("https://www.youtube.com/@Flutter_TH"),
                mode: LaunchMode.externalApplication),
            icon: const Icon(
              Icons.book,
              size: 50,
              color: Colors.red,
            ),
          ),
          // ชื่อผู้ใช้
          const Text("userName"),
          IconButton(
            onPressed: () async => {
              await GoogleSignIn().signOut(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ))
              // Navigator.pop(context)
            }
            // GoogleAPI().logout(context: context)
            ,
            icon: Icon(
              Icons.logout,
              color: kBackgroundGreen,
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}

class MenuItems {
  static const List<MenuItem> firstItems = [category, rule, system];

  static const category =
      MenuItem(text: 'ประเภทปักหมุด', icon: Icons.category_rounded);
  static const rule = MenuItem(text: 'กำหนดสิทธ์', icon: Icons.rule);
  static const system = MenuItem(text: 'จัดการระบบ', icon: Icons.settings);

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
      case MenuItems.category:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategorySettings(),
              ));
        }
        //Do something
        break;

      case MenuItems.rule:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RoleSettings(),
              ));
        }
        //Do something
        break;
      case MenuItems.system:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SystemSettings(),
              ));
        }
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
