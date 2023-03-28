// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:ux_ui_find_go/auth/google_sign.dart';
import 'package:ux_ui_find_go/auth/signup.dart';
import 'package:ux_ui_find_go/pages/main_menu.dart';
import 'package:ux_ui_find_go/server/User/crude_user.dart';
import 'package:ux_ui_find_go/server/User/model_user.dart';
import 'package:ux_ui_find_go/service/user_provider.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MainPageState();
}

class _MainPageState extends State<LoginPage> {
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  String stateEvent = "init";
  TextEditingController email = TextEditingController(),
      password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: stateEvent == "Loading user"
                ? SizedBox(
                    height: size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    children: [
                      // ด้านบน textfield กับ รูป
                      TopPicture(size: size, email: email, password: password),
                      // ด้านล่าง เป็น ไอคอนต่าง ใช้ tack สำหรับการทำให้ email อยู่ด้านบน
                      loginArea(size, context),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  ConstrainedBox loginArea(Size size, BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return ConstrainedBox(
        // ขนาดความสูงของส่วนล่าง
        constraints: BoxConstraints(
          maxHeight: size.height / 2.6,
        ),
        child: Stack(
          children: [
            // ใส่พื้นหลังเพื่อให้สามารถกำหนดที่อยู่ของIcon.login
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: kBackgroundGreen,
                    width: size.width,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Or Login with",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        // ปุมการ login ทั้งสามตัว
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.facebook,
                              color: kBackgroundGreen,
                              size: 60,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: IconButton(
                                onPressed: () =>
                                    GoogleAPI().login(context: context),
                                icon: Icon(
                                  Icons.email,
                                  color: kBackgroundGreen,
                                  size: 60,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.phone,
                              color: kBackgroundGreen,
                              size: 60,
                            ),
                            const CustomPaint()
                          ],
                        ),
                        // ปุ่ม signup

                        BasicButton(
                            text: "Signup",
                            click: true,
                            func: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupPage(),
                                  ));
                            }),

                        // ข้อความทิ้งท้าย
                        const Text(
                          "more features : 0923241242",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  _handleSignIn(userProvider: userProvider);
                },
                child: Card(
                  shape: const CircleBorder(),
                  elevation: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.login,
                      color: kClickButton,
                      size: 50,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future<void> _handleSignIn({required UserProvider userProvider}) async {
    try {
      GoogleSignInAccount? gmailUser = await GoogleSignIn().signIn();
      setState(() {
        stateEvent = "Loading user";
      });
      if (gmailUser != null) {
        LocationData location = await Location().getLocation();
        String latLong = "${location.latitude},${location.longitude}";
        // ส่ง req ขอข้อมูล User
        List<User> res = await CrudeUser().getUsers(email: gmailUser.email);
        if (res.isNotEmpty) {
          userProvider.loginSuccess(userInfo: res[0]);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainMenu(),
              ));
        } else {
          String userEndcode = jsonEncode({
            "U_Name": gmailUser.displayName,
            "U_Email": gmailUser.email,
            "U_Image": gmailUser.photoUrl,
            "U_Username": gmailUser.email.split("@").toList()[0],
            "U_Password": "gmailUser",
            "U_Location": latLong,
            "U_User_Tell": "0",
          });
          await CrudeUser().postUserData(userEndcode);
          stateEvent = "register success";
          List<User> res = await CrudeUser().getUsers(email: gmailUser.email);
          if (res.isNotEmpty) {
            userProvider.loginSuccess(userInfo: res[0]);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainMenu(),
                ));
          }
        }
      } else {
        setState(() {
          stateEvent = "login gmail failed";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(stateEvent),
          ));
        });
        debugPrint("db: Login failed No gmailUser");
        return;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}

class TopPicture extends StatelessWidget {
  const TopPicture({
    super.key,
    required this.size,
    required this.email,
    required this.password,
  });

  final Size size;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        // ขนาดความสูงของส่วนบน
        constraints: BoxConstraints(maxHeight: size.height / 2),
        child: Container(
          color: kBackgroundGreen,
          width: double.infinity,
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 160,
              width: 160,
              child: ClipOval(
                  child: Container(
                color: Colors.white,
              )),
            ),
            Expanded(
                child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextInput(
                    controller: email,
                    size: size,
                    hint: "email",
                    icons: Icons.email),
                const SizedBox(
                  height: 20,
                ),
                TextInput(
                    controller: password,
                    size: size,
                    hint: "password",
                    icons: Icons.lock),
              ],
            )),
          ]),
        ));
  }
}
