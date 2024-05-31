import 'package:fe/selectallmenus.dart';
import 'package:flutter/material.dart';

import 'mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'flutter test';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/selectallmenus': (context) => SelectAllMenus(),
      },
    );
  }
}