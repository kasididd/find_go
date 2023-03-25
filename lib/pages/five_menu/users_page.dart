import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<UsersPage> {
  List buttonsInfo = [
    {"name": "MASTER", "color": kClickButton},
    {"name": "ASSIST", "color": Colors.redAccent},
    {"name": "SLAVE", "color": Colors.green[600]},
  ];
  List levels = [
    {"name": "MASTER", "color": kClickButton},
    {"name": "ASSIST", "color": Colors.redAccent},
    {"name": "SLAVE", "color": Colors.green[600]},
    {"name": "SLAVE", "color": Colors.green[600]},
    {"name": "ADMIN", "color": Colors.blue},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: BasicAppbar(title: "ส่วนตัวของฉัน - User")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // button
          SizedBox(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < buttonsInfo.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                backgroundColor: buttonsInfo[i]["color"]),
                            onPressed: () {},
                            child: Text(
                              buttonsInfo[i]['name'],
                              style: const TextStyle(fontSize: 24),
                            ))),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => Card(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: size.width * .8,
                                  height: 500,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.red,
                                              ),
                                              width: 80,
                                              height: 80,
                                            ),
                                            const Text("user name"),
                                            const Text(
                                              "คุณต้องการเปลี่ยนสิทธ์เป็น ?",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              for (int i = 0;
                                                  i < levels.length;
                                                  i++)
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: levels[i]
                                                          ["color"],
                                                    ),
                                                    onPressed: () {},
                                                    child: Text(
                                                      levels[i]['name'],
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))
                                            ],
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red,
                              ),
                              width: 60,
                              height: 60,
                            ),
                            title: const Text("Slave :master/assist"),
                            subtitle: const Text("หัวหน้าห้อง"),
                            trailing: const Icon(
                              Icons.person_search_rounded,
                              size: 50,
                            ),
                          ),
                        ),
                      )))
        ],
      ),
    );
  }
}
