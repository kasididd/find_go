// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:location/location.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ux_ui_find_go/pages/main_menu.dart';
import 'package:ux_ui_find_go/server/User/crude_user.dart';
import 'package:ux_ui_find_go/server/User/model_user.dart';
import 'package:ux_ui_find_go/utility/basic.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:http/http.dart' as http;
import '../const.dart';
import '../server/Room/model_room.dart';
import '../service/room_provider.dart';
import '../service/user_provider.dart';
import 'five_menu/social_page.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key, required this.IDroom});
  final String IDroom;
  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  // ? mapsVariable
  final Completer<GoogleMapController> _controller = Completer();
  String stateEvent = "init";
  LocationData? currentLocation;
  List<User> roomUser = [];
  Set<Marker> _markers = <Marker>{};
  BitmapDescriptor mylocation = BitmapDescriptor.defaultMarker;
  bool volumeOff = true, share = false;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  int count = -1, passCount = 0, round = 25;
  @override
  void initState() {
    setCustomerMarker();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("โปรกดปุ่มด้านนซ้ายเพื่อออก")));
          return false;
        },
        child: SafeArea(
            child: Column(
          children: [
            // ชั้นที่ 1 ปุ่มย้อนกลับ ชื่อผู้ใช้ ปุ่มปิดเสียง รูปผู้ใช้
            appBar(context),
            // ชื่อห้อง
            const NameRoom(),
            // ทางลัดโซเชี่ยว เลขห้อง กดเข้าแก้ไข
            social(context, size),
            // ไอคอน หลัก
            fiveIcons(context),
            //mainGoogleMaps
            mainMaps()
          ],
        )),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45.0),
        child: floatingSpeedDial(context),
      ),
    );
  }

  Expanded mainMaps() {
    RoomProvider roomProvider = context.watch<RoomProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    return Expanded(
        child: SizedBox(
      width: double.infinity,
      child: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                    buildingsEnabled: true,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: true,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    onMapCreated: (controller) {
                      getDataRoomUsers(
                          roomProvider: roomProvider,
                          userProvider: userProvider);
                      // setMarker();
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                        zoom: 12,
                        target: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!)),
                    markers: _markers),
              ],
            ),
    ));
  }

  Row fiveIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < 5; i++)
          Column(
            children: [
              IconButton(
                onPressed: () {
                  if (Icons.phone == fiveMenu[i]['icon']) {
                    if (kDebugMode) {
                      print("same");
                    }

                    _makePhoneCall(fiveMenu[i]['label']);
                  }
                  if (fiveMenu[i]['pages'] != "") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => fiveMenu[i]['pages'],
                        ));
                  }
                },
                icon: Icon(fiveMenu[i]['icon']),
                iconSize: 40,
                color: kBackgroundGreen,
              ),
              Text(fiveMenu[i]['label'])
            ],
          )
      ],
    );
  }

  Row social(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < 2; i++)
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SocialPage(),
                            ));
                      },
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade200),
                      icon: Icon(
                        fourSocial[i],
                        size: 30,
                      )),
                  const Text("data")
                ],
              ),
          ],
        ),
        Row(
          children: [
            Text(widget.IDroom),
            IconButton(
                onPressed: () async {
                  await showCustomeDialog(context, size);
                },
                icon: const Icon(Icons.edit)),
          ],
        ),
        Row(
          children: [
            for (int i = 2; i < 4; i++)
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SocialPage(),
                            ));
                      },
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade200),
                      icon: Icon(
                        fourSocial[i],
                        size: 30,
                      )),
                  const Text("Icon")
                ],
              ),
          ],
        ),
      ],
    );
  }

  Row appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () async {
            share = false;
            snackBarUpdate();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainMenu(),
                ));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: kBackgroundGreen,
            weight: 20,
            size: 35,
          ),
        ),
        const Icon(
          Icons.abc,
          color: Colors.white,
          size: 35,
        ),
        Text(
          "User name",
          style: TextStyle(
              color: kBackgroundGreen,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  volumeOff = !volumeOff;
                });
              },
              icon: Icon(
                volumeOff ? Icons.volume_off : Icons.volume_down_rounded,
                size: 35,
                color: kBackgroundGreen,
              ),
            ),
            IconButton(
              onPressed: () async {
                final res = await http.post(
                    Uri.parse("http://127.0.0.1:5000/updateLocation"),
                    body: jsonEncode({"location": "fassd"}),
                    headers: {'content-type': 'application/json'});
                print(res.statusCode);
              },
              icon: Icon(
                Icons.image,
                size: 35,
                color: kBackgroundGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // functionVariable
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) async {
      currentLocation = location;
      // ส่งข้อมูลที่อยู่ใหม่
      if (kDebugMode) {
        print(location);
      }
      try {
        final res = await http.post(Uri.parse("http://127.0.0.1:5000/get"),
            body: jsonEncode({"table": "users", "id": "1"}),
            headers: {'content-type': 'application/json'});
        // print(res.body);
        passCount++;
        final usersLocation = jsonDecode(res.body)['message'][0][5];
        if (kDebugMode) {
          print(res.statusCode);
        }
        // print(usersLocation);
        locationMarker(
            newPosition: LatLng(
                double.parse(usersLocation.toString().split(",")[0]),
                double.parse(usersLocation.toString().split(",")[1])));
      } catch (e) {
        print("err : $e");
      }
      setState(() {});
    });
  }

  void setCustomerMarker() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/user.png")
        .then((value) => mylocation = value);
  }

  SpeedDial floatingSpeedDial(BuildContext context) {
    RoomProvider roomProvider = context.watch<RoomProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      openCloseDial: isDialOpen,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      overlayColor: Colors.grey,
      overlayOpacity: 0.5,
      spacing: 15,
      spaceBetweenChildren: 15,
      closeManually: true,
      children: [
        SpeedDialChild(
            child:
                share ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
            label: 'Watch',
            backgroundColor: kBackgroundGreen,
            onTap: () {
              setState(() {
                isDialOpen.value = false;
                if (share) {
                  share = false;
                  snackBarUpdate();
                } else {
                  showDialogMessage(context);
                }
              });
            }),
        SpeedDialChild(
            child: const Icon(Icons.near_me),
            label: 'My Location',
            backgroundColor: Colors.blue,
            onTap: mylocationNow),
        SpeedDialChild(
            backgroundColor: Colors.blue,
            child: const Icon(Icons.refresh),
            label: 'Refresh My Room',
            onTap: () => getDataRoomUsers(
                roomProvider: roomProvider, userProvider: userProvider)),
        SpeedDialChild(
            backgroundColor: Colors.blue,
            child: const Icon(Icons.visibility_off),
            label: 'Hide pins',
            onTap: hideMarker),
      ],
    );
  }

  Future<dynamic> pinDialog(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: size.height * .6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        size: 40,
                        color: kBackgroundGreen,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.image,
                  size: 300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.add_location_alt_sharp,
                      size: 30,
                      color: kBackgroundGreen,
                    ),
                    const Text("address")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.phone,
                      size: 30,
                      color: kBackgroundGreen,
                    ),
                    const Text("0928382832")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //  Dialog ถามส่าจะเปิดการแชร์ตำแหน่งไหม
  Future<dynamic> showDialogMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("แจ้งเตือน"),
        content: const Text("Update ตำแหน่งของคุณ"),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.pop(context), child: const Text("No")),
          OutlinedButton(
              onPressed: () async {
                share = true;
                round = 0;
                if (round == 0) {
                  setState(() {
                    share = true;
                    // หากกดyes จะทำการloop ค่าที่ตั้งไว้
                    if (share) {
                      snackBarUpdate();
                      Navigator.pop(context);
                    }
                  });
                }
                const Duration(seconds: 1);
              },
              child: const Text("Yes")),
        ],
      ),
    );
  }

  Future<dynamic> showCustomeDialog(BuildContext context, Size size) {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            icon: Icons.edit,
            title: "",
            content: SizedBox(
              height: size.height / 1.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextInputDialog(
                        size: size,
                        icons: Icons.text_fields,
                        hint: "กรอกเลขห้อง"),
                    const SizedBox(
                      height: 30,
                    ),
                    TextAreaInputDialog(
                        size: size, icons: Icons.info, hint: "รายละเอียด"),
                    const SizedBox(
                      height: 30,
                    ),
                    TextInputDialog(
                        size: size, icons: Icons.phone, hint: "เบอร์โทรศัพท์"),
                    const SizedBox(
                      height: 30,
                    ),
                    TextInputDialog(
                        size: size,
                        icons: Icons.location_city_rounded,
                        hint: "แก้ไขจังหวัด"),
                    for (int i = 0; i < 4; i++)
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          TextInputDialog(
                              size: size,
                              icons: Icons.mediation,
                              hint: "Social ${i + 1}"),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            positiveBtnText: "ยกเลิก",
            negativeBtnText: "แก้ไข",
            positiveBtnPressed: () {
              // Do something here
              Navigator.of(context).pop();
            },
          );
        });
  }

// อับเดท scanckBar
  snackBarUpdate() async {
    // หากค่าroudน้อยกว่า25 และ ไม่มีการบังคับหยุด
    int end = 25;
    if (share) {
      setState(() {});
      while (round < end) {
        round += 1;
        final snackBaralert = SnackBar(
            duration: const Duration(seconds: 1),
            content: Text("Watch ตำแหน่งปัจจุบัน ครั้งที่ $round/25"));
        ScaffoldMessenger.of(context).showSnackBar(snackBaralert);
      }
    }

    // หาก มีการแชร์อยู่ จะ ทำการหยุดแชร์โดยการสั่งให้ลบการืำงานทั้งหมด
    else {
      for (int i = 0; i < end; i++) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  // ignore: todo
  // TODO รับที่อยู่ของสมาชิกในห้อง
  void addMarkerUser({required User user}) async {
    List<double> current =
        user.uLocation.split(",").toList().map((e) => double.parse(e)).toList();
    LatLng latLng = LatLng(current[0], current[1]);
    if (user.uImage == "None") {
      _markers.addLabelMarker(LabelMarker(
        label: user.uUsername,
        markerId: MarkerId(user.uID.toString()),
        position: latLng,
        backgroundColor: kClickButton,
      ));
    } else {
      _markers.add(
        Marker(
          markerId: MarkerId(user.uID.toString()),
          icon: await MarkerIcon.downloadResizePictureCircle(user.uImage,
              size: 150,
              addBorder: true,
              borderColor: Colors.white,
              borderSize: 15),
          infoWindow: InfoWindow(title: user.uUsername, snippet: user.uName),
          visible: true,
          position: latLng,
        ),
      );
    }
    setState(() {});
  }

  void setMarker() async {
    _markers.add(
      Marker(
          markerId: const MarkerId('1'), //ใช้ ID ของ User
          icon: await MarkerIcon.downloadResizePictureCircle(
              'https://pixlr.com/images/index/remove-bg.webp', //ใช้รูปของ User
              size: 150,
              addBorder: true,
              borderColor: kBackgroundGreen,
              borderSize: 15),
          position: LatLng(
              // ที่อยู่ User
              currentLocation!.latitude! - .002,
              currentLocation!.longitude!),
          onTap: () async {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Container(
                  height: getSize(context).height * .8,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.map),
                        onPressed: () async {
                          final availableMaps = await MapLauncher.installedMaps;
                          if (kDebugMode) {
                            print(availableMaps);
                          } // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                          await availableMaps.first.showMarker(
                            coords: Coords(currentLocation!.latitude!,
                                currentLocation!.longitude! - .01),
                            title: "แถว บ้าน",
                          );
                        },
                      ),
                      const Text("นำทาง")
                    ],
                  ),
                ),
              ),
            );
          }),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('2'),
        icon: await MarkerIcon.downloadResizePictureCircle(
            'https://pixlr.com/images/index/remove-bg.webp',
            size: 150,
            addBorder: true,
            borderColor: Colors.white,
            borderSize: 15),
        infoWindow: const InfoWindow(title: "hello", snippet: "hi they"),
        visible: true,
        position: LatLng(
            currentLocation!.latitude! - .02, currentLocation!.longitude!),
      ),
    );

    setState(() {});
  }

  mylocationNow() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 16)));
  }

  void hideMarker() async {
    Set<Marker> update = <Marker>{};
    for (Marker target in _markers) {
      target = target.copyWith(visibleParam: !target.visible);
      update.add(target);
      setState(() {
        _markers = update;
      });
    }
  }

  void getDataRoomUsers(
      {required RoomProvider roomProvider,
      required UserProvider userProvider}) {
    stateEvent = "get Users...";
    roomUser = [];
    _markers.clear();
    List<RoomMember>? roomMember = roomProvider.roomMember;
    roomMember?.asMap().entries.map((e) async {
      List<User> res = await CrudeUser().getUsersID(uID: e.value.userMember);
      if (res.isNotEmpty) {
        roomUser.add(res[0]);
        if (res[0].uID != userProvider.userInfo!.uID) {
          addMarkerUser(user: res[0]);
        }
      }
    }).toList();
  }

  void locationMarker({required LatLng newPosition}) async {
    Set<Marker> update = <Marker>{};
    for (Marker target in _markers) {
      if (target.mapsId.value == "1") {
        target = target.copyWith(positionParam: newPosition);
        update.add(target);
        setState(() {
          _markers = update;
        });
      }
    }
  }
}

class NameRoom extends StatelessWidget {
  const NameRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Icon(Icons.lock), Text("room name")],
    );
  }
}
