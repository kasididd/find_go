import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ux_ui_find_go/pages/five_menu/pins_page.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class PinsSettings extends StatefulWidget {
  const PinsSettings({super.key});

  @override
  State<PinsSettings> createState() => _PinsSettingsState();
}

class _PinsSettingsState extends State<PinsSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.close,
                          size: 35,
                          color: kBackgroundGreen,
                        ),
                        Text("ตั้งค่าประเภทหมุด\n(Category)",
                            style: TextStyle(
                                fontSize: 24, color: kBackgroundGreen)),
                        SizedBox(
                          width: 30,
                        )
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 200,
                child: BasicButton(
                  click: false,
                  text: "➕ สร้างหมุด",
                  func: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategorySettings(),
                      )),
                )),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("ชื่อ"),
                  subtitle: Text("รายละเอียด"),
                  trailing: Icon(Icons.person_add_alt_1_rounded),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class CategorySettings extends StatefulWidget {
  const CategorySettings({super.key});

  @override
  State<CategorySettings> createState() => _AddPinsMapsState();
}

class _AddPinsMapsState extends State<CategorySettings> {
  List<String> items = ["ใช้งาน", "ไม่ใช้"];
  String type = "ใช้งาน";
  XFile? image;

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);

    return (Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 35,
                        color: kBackgroundGreen,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.add_location_alt_rounded,
                          color: kClickButton,
                          size: 40,
                        ),
                        Text("เพิ่มหมุดบนแผนที่",
                            style: TextStyle(
                                fontSize: 24, color: kBackgroundGreen)),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    )
                  ]),
            ),
          ),
        ),
      ),
      body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextInputDialog(
                  size: size,
                  icons: Icons.text_fields_rounded,
                  hint: "ชื่อประเภท"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("สถานะ"),
                  DropdownButton(
                    value: type,
                    items: items
                        .map((String e) =>
                            DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      type = value.toString();
                    }),
                  ),
                ],
              ),
              // TODO เพิ่มรูปประเภทหมุด
              TextButton(
                onPressed: () => getImage(),
                child: image != null
                    ? ClipOval(
                        child: Image.file(
                        File(image!.path),
                        filterQuality: FilterQuality.medium,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      ))
                    : Icon(
                        Icons.image,
                        size: 300,
                        color: kBackgroundGreen,
                      ),
              ),
              BasicButton(click: false, text: "สร้างหมุด"),
              SizedBox(
                height: 20,
              )
            ],
          )),
    ));
  }

  void getImage() async {
    final getImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image == null
          ? image = getImage
          : getImage != null
              ? image = getImage
              : null;
    });
  }
}
