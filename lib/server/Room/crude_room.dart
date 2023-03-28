import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ux_ui_find_go/server/Room/model_room.dart';

import '../config.dart';

// CRUDE
class CrudeRoom {
  // C
  Future<void> postRoom(String name, String email) async {
    final url = Uri.parse(crudeRoomL);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'name': name, 'email': email});
    final response =
        await http.post(Uri.parse('https://example.com/api/rooms'), body: {
      'R_Description': 'Test room',
      'Images': 'https://example.com/images/testroom.jpg',
      'R_Owner': '1',
      'R_Name': 'Test Room',
      'R_Type': '1',
      'R_Tell': '1234567890',
      'R_Detail': 'This is a test room',
      'Province': 'Bangkok, Thailand'
    });

    if (response.statusCode == 200) {
      // สำเร็จ
    } else {
      // ไม่สำเร็จ
    }
  }

  // R
  Future<List<Room>> getRooms() async {
    final response = await http.get(Uri.parse(crudeRoomL));
    if (response.statusCode == 200) {
      final List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((user) => Room.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // C - member
  Future<int> postRoomMember({required RoomMember roomMember}) async {
    final body = jsonEncode(roomMember.toJson());
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(crudeRoomMembersL),
        headers: headers, body: body);
    print(body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return 200;
      // สำเร็จ
    } else {
      throw Exception('Failed to create RoomMember');
    }
  }

  // R - members
  Future<List<RoomMember>> getRoomsMembers({required String roomID}) async {
    final response = await http.get(Uri.parse("$crudeRoomMembersL/$roomID"));
    if (response.statusCode == 200) {
      final List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((user) => RoomMember.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
