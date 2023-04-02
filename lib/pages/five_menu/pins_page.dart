import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class PinsPage extends StatefulWidget {
  const PinsPage({super.key});

  @override
  State<PinsPage> createState() => _PinsPageState();
}

class _PinsPageState extends State<PinsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close,
                            size: 35,
                            color: kBackgroundGreen,
                          ),
                        ),
                        Text("ชื่อผู้ใช้",
                            style: TextStyle(
                                fontSize: 24, color: kBackgroundGreen)),
                        const SizedBox(
                          width: 30,
                        )
                      ]),
                  Center(
                    child: Text(
                      "Pins",
                      style: TextStyle(color: kBackgroundGreen, fontSize: 20),
                    ),
                  )
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
                  text: "สร้างหมุด",
                  func: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AddPinsMaps(position: LatLng(0, 0)),
                      )),
                )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("ชื่อ"),
                  subtitle: Text("รายละเอียด"),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class AddPinsMaps extends StatefulWidget {
  const AddPinsMaps({super.key, required this.position});
  final LatLng position;
  @override
  State<AddPinsMaps> createState() => _AddPinsMapsState();
}

class _AddPinsMapsState extends State<AddPinsMaps> {
  List<String> items = ["addPinsMaps", "ed", "asc", "addP"];
  String type = "addPinsMaps";
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);

    return (Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
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
                      Icon(
                        Icons.add_location_alt_rounded,
                        color: kClickButton,
                        size: 40,
                      ),
                      Text("เพิ่มหมุดบนแผนที่",
                          style:
                              TextStyle(fontSize: 24, color: kBackgroundGreen)),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
            width: double.infinity,
            height: 1300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("ประเภทหมุด"),
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
                TextInputDialog(
                    size: size, icons: Icons.text_fields_rounded, hint: "ชื่อ"),
                TextAreaInputDialog(size: size, hint: "รายละเอียด"),
                const Text('ตำแหน่งการแสดงหมุดบนแผนที่ คลิกที่อยู่'),
                TextAreaInputDialog(size: size, hint: "ที่อยู่"),
                TextInputDialog(
                    size: size,
                    icons: Icons.phone,
                    hint: "เบอร์โทรศัพท์(ถ้ามี)"),
                TextInputDialog(
                    size: size,
                    icons: Icons.web_asset,
                    hint: "เว็ยไซต์(ถ้ามี)"),
                const Icon(
                  Icons.image,
                  size: 300,
                ),
                const BasicButton(click: false, text: "สร้างหมุด"),
                const SizedBox(
                  height: 20,
                )
              ],
            )),
      ),
    ));
  }
}
