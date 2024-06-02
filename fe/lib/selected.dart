import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class Selected extends StatelessWidget {
  const Selected({super.key});

  @override
  Widget build(BuildContext context) {
    final baseUrl = 'http://10.0.2.2:8080/menus';
    final dio = Dio();
    final transfer = ModalRoute.of(context)!.settings.arguments;
    Menu menu = Menu.fromJson(transfer); // arguments로 전달받은 menu를 객체로 변환

    return Scaffold(
      appBar: AppBar(
        title: const Text('selected'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('menu code : ${menu.menuCode}'),
          Text('menu name : ${menu.menuName}'),
          Text('menu price : ${menu.menuPrice}'),
          Text('category code : ${menu.categoryCode}'),
          Text('orderable status : ${menu.orderableStatus}'),
        ],
      ),
      floatingActionButton: Stack(
        // FloatingActionButton 2개 이상 사용하기
        children: <Widget>[
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.2),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context)
                    .popAndPushNamed('/updatemenu', arguments: menu.menuCode);
              },
              icon: const Icon(Icons.edit),
              label: Text('update'),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: () async {
                final requestUrl = baseUrl + "/" + menu.menuCode.toString();
                var responses = await dio.delete(requestUrl);

                Navigator.of(context).pushReplacementNamed('/selectallmenus');
              },
              icon: const Icon(Icons.delete),
              label: Text('delete'),
            ),
          ),
        ],
      ),
    );
  }
}