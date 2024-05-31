import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class SelectAllMenus extends StatefulWidget {
  const SelectAllMenus({super.key});

  @override
  State<SelectAllMenus> createState() => _SelectAllMenusState();
}

class _SelectAllMenusState extends State<SelectAllMenus> {
  List? data; // 결과 데이터를 저장할 리스트
  final dio = Dio();
  var url = 'http://10.0.2.2:8080/menus';

  _asyncMethod() async {
    final response = await dio.get(url);
    setState(() {
      print(response.data);
      data = response.data;
    });
  }

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
        child: Text(
          '불러오기',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dio = Dio();
          var url = 'http://10.0.2.2:8080/menus';
          // flutter에서는 localhost 대신 10.0.2.2 사용
          Map<String, String> headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          };
          print('pressed');
          // var uri = Uri.parse(url);
          // http.Response response = await http.get(uri);
          final response = await dio.get(url);
          // print(response);
          // print(response.body);
          // print(response.body.length);
          print(response.data);

          // var dataConvertedToJSON = json.decode(response.body);
          // print(dataConvertedToJSON);
          // print(dataConvertedToJSON['results']);
          // print(dataConvertedToJSON['results']['menus']);
          // print(dataConvertedToJSON['results']['menus'][20]);
          print(response.data['results']);
          print(response.data['results']['menus']);
          print(response.data['results']['menus'][20]);
        },
        child: Icon(Icons.file_download),
      ),
    );
  }
}
