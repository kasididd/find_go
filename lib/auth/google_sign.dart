import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ux_ui_find_go/auth/login.dart';
import 'package:ux_ui_find_go/pages/main_menu.dart';

class GoogleAPI {
  dynamic user;
  static final _google = GoogleSignIn(
      clientId:
          "706079540857-253f454uncscbbsklg15c743tf7gi83r.apps.googleusercontent.com");
  Future login({required context}) async {
    user = await _google.signIn();
    if (user != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainMenu(),
          ));
    }
  }

  Future logout({required context}) async {
    await _google.disconnect();
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }
}
