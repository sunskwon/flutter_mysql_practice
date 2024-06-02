import 'package:flutter/material.dart';

import 'menu.dart';

class Selected extends StatelessWidget {
  const Selected({super.key});

  @override
  Widget build(BuildContext context) {
    final transfer = ModalRoute.of(context)!.settings.arguments;
    // print(transfer);
    Menu menu = Menu.fromJson(transfer);
    // print(menu);
    // print(menu.menuCode);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).popAndPushNamed('/updatemenu', arguments: menu.menuCode);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
