import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ux_ui_find_go/server/User/model_user.dart';

import '../config.dart';

// CRUDE
class CrudeUser {
  // C
  Future<void> postUserData(String userEndcode) async {
    final url = Uri.parse(crudeUserL);
    final headers = {'Content-Type': 'application/json'};
    final body = userEndcode;
    final response = await http.post(url, headers: headers, body: body);
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
    } else {
      if (kDebugMode) {
        print('Error posting data: ${response.statusCode}');
      }
    }
  }

  // R{Email}
  Future<List<User>> getUsers({required String email}) async {
    final response = await http.get(Uri.parse('$crudeUserL/"$email"'));
    debugPrint("db: ${response.statusCode}");
    if (response.statusCode == 200) {
      debugPrint("db: body ${response.body}");
      if (response.body[0] == "[") {
        final List<dynamic> usersJson = jsonDecode(response.body);
        return usersJson.map((user) => User.fromJson(user)).toList();
      }
      return [];
    } else {
      throw Exception('Failed to load users');
    }
  }

  // R{u_id}
  Future<List<User>> getUsersID({required int uID}) async {
    final response = await http.get(Uri.parse('$crudeUserL/$uID'));
    if (response.statusCode == 200) {
      final List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
