import 'package:flutter/material.dart';

import '../server/User/model_user.dart';

class UserProvider with ChangeNotifier {
  User? userInfo;
  void loginSuccess({required userInfo}) {
    this.userInfo = userInfo;
  }
}
