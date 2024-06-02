import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class SelectMenuByCode extends StatefulWidget {
  const SelectMenuByCode({super.key});

  @override
  State<SelectMenuByCode> createState() => _SelectMenuByCodeState();
}

class _SelectMenuByCodeState extends State<SelectMenuByCode> {
  final baseUrl = 'http://10.0.2.2:8080';
  final dio = Dio();
  Menu? menu;

  @override
  Widget build(BuildContext context) {
    final transfer = ModalRoute.of(context)!.settings.arguments;

    Future<Menu?> _asyncMethod() async {
      final url = baseUrl + transfer.toString();

      final response = await dio.get(url);
      setState(() {
        menu = Menu.fromJson(response.data['results']['menu']);
      });

      return menu;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('select menu by code'),
      ),
      body: FutureBuilder(
        future: _asyncMethod(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: Column(
                children: [
                  Text('데이터가 없습니다'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          else if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}',
            );
          }
          else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('menu code : ${menu?.menuCode}'),
                Text('menu name : ${menu?.menuName}'),
                Text('menu price : ${menu?.menuPrice}'),
                Text('category code : ${menu?.categoryCode}'),
                Text('orderable status : ${menu?.orderableStatus}'),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).popAndPushNamed('/updatemenu', arguments: menu?.menuCode);
        },
        icon: const Icon(Icons.edit),
        label: Text('update'),
      ),
    );
  }
}