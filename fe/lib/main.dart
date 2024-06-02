import 'package:fe/selectmenubycode.dart';
import 'package:fe/selectallmenus.dart';
import 'package:fe/selected.dart';
import 'package:fe/updatemenu.dart';
import 'package:flutter/material.dart';

import 'insertmenu.dart';
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
        '/selectallmenus': (context) => SelectAllMenus(), // 전체 메뉴 조회
        '/selected': (context) => Selected(),   // 전체 메뉴 조회 => 단일 조회
        '/insertmenu': (context) => InsertMenu(), // 신규 메뉴 추가
        '/selectmenubycode': (context) => SelectMenuByCode(), // 단일 메뉴 조회
        '/updatemenu': (context) => UpdateMenu(), // 메뉴 수정
      },
    );
  }
}
