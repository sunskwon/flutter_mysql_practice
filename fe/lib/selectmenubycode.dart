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
  Menu? menu;
  final dio = Dio();
  final baseUrl = 'http://10.0.2.2:8080';

  @override
  Widget build(BuildContext context) {
    final transfer = ModalRoute.of(context)!.settings.arguments;
    // print('transfer $transfer');

    Future<Menu?> _asyncMethod() async {
      final url = baseUrl + transfer.toString();
      // print('url : $url');

      final response = await dio.get(url);
      // print(response);
      // print(response.data);
      // print(response.data['results']);
      // print(response.data['results']['menu']);
      setState(() {
        menu = Menu.fromJson(response.data['results']['menu']);
        // print(menu);
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
    );
  }
}
