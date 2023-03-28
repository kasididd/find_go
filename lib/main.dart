import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_ui_find_go/auth/login.dart';
import 'package:ux_ui_find_go/service/room_provider.dart';
import 'package:ux_ui_find_go/service/user_provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => RoomProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

// main Page
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoFinding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(
            // Listtile title
            titleMedium: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
            // Listtile subtitle
            bodySmall: TextStyle(color: Colors.grey.shade800),
            // text ตัวเริ่มต้น
            bodyMedium: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),

            // ไม่ได้ใช้
            headlineMedium: const TextStyle(color: Colors.yellow),
            labelLarge: const TextStyle(color: Colors.yellow),
            displayMedium: const TextStyle(color: Colors.yellow),
            displayLarge: const TextStyle(color: Colors.yellow),
            labelSmall: const TextStyle(color: Colors.yellow),
            displaySmall: const TextStyle(color: Colors.yellow),
            labelMedium: const TextStyle(color: Colors.yellow),
            // title Dialog
            headlineSmall: const TextStyle(color: Colors.black),

            // textField
            bodyLarge: const TextStyle(color: Colors.black),
            // ห้ามใช้
            // subtitle2: TextStyle(color: Colors.red),

            // headline3: TextStyle(color: Colors.red),
            // caption: TextStyle(color: Colors.red),
          ),
          useMaterial3: true,
          primarySwatch: Colors.blue,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.white))),
      home: const
          //  Test()
          LoginPage(),
    );
  }
}
