import 'package:flutter/material.dart';
import 'package:ux_ui_find_go/pages/five_menu/chat_page.dart';
import 'package:ux_ui_find_go/pages/five_menu/invate_page.dart';
import 'package:ux_ui_find_go/pages/five_menu/pins_page.dart';
import 'package:ux_ui_find_go/pages/five_menu/users_page.dart';

// mapsPage
List fiveMenu = [
  {"icon": Icons.person, "label": "Users", "pages": const UsersPage()},
  {"icon": Icons.phone, "label": "0983848383", "pages": ""},
  {"icon": Icons.message, "label": "Chat", "pages": const ChatePage()},
  {"icon": Icons.location_pin, "label": "Pins", "pages": const PinsPage()},
  {"icon": Icons.add, "label": "Invite", "pages": const InvatePage()},
];
List fourSocial = [
  Icons.mobile_screen_share_rounded,
  Icons.mobile_screen_share_rounded,
  Icons.mobile_screen_share_rounded,
  Icons.mobile_screen_share_rounded,
];
