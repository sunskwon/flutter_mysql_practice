import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectAllMenus extends StatefulWidget {
  const SelectAllMenus({super.key});

  @override
  State<SelectAllMenus> createState() => _SelectAllMenusState();
}

class _SelectAllMenusState extends State<SelectAllMenus> {
  List? data; // 결과 데이터를 저장할 리스트

  @override
  void initState() {
    super.initState();
    data = new List.empty(growable: true);
  }

  // Future<String> getJSONData() async {
  //   var url = 'http://localhost:8080/menus';
  //   var response = await http.get(Uri.parse(url));
  //   print(response.body);
  //
  //   setState(() {
  //     var dataConvertedToJSON = json.decode(response.body);
  //     List result = dataConvertedToJSON['']
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('select all menus'),
      ),
      body: Container(
        child: TextButton(
          onPressed: () {
            // getJSONData();
          },
          child: Text('불러오기'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var url = 'http://localhost:8080/menus';
          print('pressed');
          var response = http.get(Uri.parse(url));
        },
        child: Icon(Icons.file_download),
      ),
    );
  }
}
