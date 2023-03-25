import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  bool editing = false;
  List<Social> socialList = [
    Social(icon: Icons.abc, label: "ABC"),
    Social(icon: Icons.facebook, label: "My Facebok"),
    Social(icon: Icons.baby_changing_station, label: "Facebok kasidid"),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.grey.shade100,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .95,
            crossAxisCount: 3,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7),
        itemCount: socialList.length + 1,
        itemBuilder: (context, index) => Card(
          color: Theme.of(context).cardColor,
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  if (index > 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LinkSocial(),
                        ));
                  }
                  if (index == 0) showCustomeDialog(context, size);
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: kBackgroundGreen,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            index > 0 ? socialList[index - 1].icon : Icons.add,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          index > 0
                              ? socialList[index - 1].label.length < 17
                                  ? socialList[index - 1].label
                                  : socialList[index - 1]
                                          .label
                                          .substring(0, 17) +
                                      "..."
                              : "add",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 16, overflow: TextOverflow.fade),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  child: IconButton(
                    //TODO remove
                    onPressed: () {},
                    icon: Icon(
                      editing ? Icons.delete : Icons.more_vert,
                      color: editing ? Colors.red : Colors.black,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
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
                      Icons.close,
                      size: 35,
                      color: kBackgroundGreen,
                    ),
                  ),
                  Text("ชื่อผู้ใช้",
                      style: TextStyle(fontSize: 24, color: kBackgroundGreen)),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        editing = !editing;
                      });
                    },
                    icon: Icon(
                      editing ? Icons.close : Icons.edit,
                      size: 30,
                      color: kBackgroundGreen,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class LinkSocial extends StatefulWidget {
  const LinkSocial({super.key});

  @override
  State<LinkSocial> createState() => _LinkSocialState();
}

class _LinkSocialState extends State<LinkSocial> {
  List allLinks = [
    "https://www.youtube.com/watch?v=4h3sT0VYdSQ&ab_channel=BlackDotCompanyLimited",
  ];
  TextEditingController linkValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          size: 40,
                          color: kBackgroundGreen,
                        ),
                      ),
                      Text("ชื่อSocial",
                          style:
                              TextStyle(fontSize: 24, color: kBackgroundGreen)),
                      IconButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("เพิ่มลิงค์"),
                            content: TextField(
                              controller: linkValue,
                            ),
                            actions: [
                              OutlinedButton(
                                  onPressed: () => {
                                        allLinks.add(linkValue.text),
                                        Navigator.pop(context),
                                        print(allLinks),
                                        setState(() {})
                                      },
                                  child: Text("เพิ่มลิงค์"))
                            ],
                          ),
                        ),
                        icon: Icon(
                          Icons.add,
                          size: 30,
                          color: kBackgroundGreen,
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
        body: allLinks.isEmpty
            ? Center(
                child: Text("ไม่มีลิงค์"),
              )
            : ListView.builder(
                itemCount: allLinks.length,
                itemBuilder: (context, index) => Stack(
                  children: [
                    addLink(link: allLinks[index]),
                    Positioned(
                        right: 10,
                        top: 10,
                        child: IconButton(
                            onPressed: () =>
                                {allLinks.removeAt(index), setState(() {})},
                            icon: Icon(Icons.close))),
                  ],
                ),
              ));
  }

  SimpleUrlPreview addLink({required String link}) {
    return SimpleUrlPreview(
      url: link,
      bgColor: Colors.white,
      // isClosable: true,
      previewHeight: 200,
      previewContainerPadding: EdgeInsets.all(10),
      titleLines: 1,
      descriptionLines: 2,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
      ),
      siteNameStyle: TextStyle(
        fontSize: 14,
      ),
      onTap: () => launchUrl(
        Uri.parse(link),
        mode: LaunchMode.externalApplication,
      ),
    );
  }
}

Future<dynamic> showCustomeDialog(BuildContext context, Size size) {
  return showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          icon: Icons.add,
          title: "",
          content: SizedBox(
            height: size.height / 2,
            child: SizedBox(
              child: Column(
                children: [
                  // const Icon(
                  //   Icons.image,
                  //   size: 200,
                  // ),
                  const Text("เลือกIcon"),
                  Expanded(
                      child: GridView.builder(
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) => const Icon(
                      Icons.facebook,
                      size: 60,
                    ),
                  )),
                  // const BasicButton(click: false, text: "เลือกรูป"),

                  TextInputDialog(
                      size: size,
                      icons: Icons.text_fields_rounded,
                      hint: "กรอกชื่อโซเชี่ยว"),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
          positiveBtnText: "ยกเลิก",
          negativeBtnText: "เพิ่ม",
          positiveBtnPressed: () {
            // Do something here
            Navigator.of(context).pop();
          },
        );
      });
}

class Social {
  Social({required this.icon, required this.label});
  final String label;
  final IconData icon;
}
