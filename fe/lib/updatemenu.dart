import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class UpdateMenu extends StatefulWidget {
  const UpdateMenu({super.key});

  @override
  State<UpdateMenu> createState() => _UpdateMenuState();
}

class _UpdateMenuState extends State<UpdateMenu> {
  final baseUrl = 'http://10.0.2.2:8080/menus';
  final dio = Dio();
  Menu? menu;
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  int menuCode = 0;
  String menuName = '';
  int menuPrice = 0;
  int categoryCode = 0;
  String orderableStatus = 'N';

  TextEditingController? _menuNameController;
  TextEditingController? _menuPriceController;
  TextEditingController? _categoryCodeController;
  TextEditingController? _orderableStatusController;

  @override
  void initState() {
    super.initState();
    _menuNameController = TextEditingController();
    _menuPriceController = TextEditingController();
    _categoryCodeController = TextEditingController();
    _orderableStatusController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final transfer = ModalRoute.of(context)!.settings.arguments;

    Future<Menu?> _asyncMethod() async {
      final url = baseUrl + '/' + transfer.toString();
      final response = await dio.get(url);

      setState(() {
        menu = Menu.fromJson(response.data['results']['menu']);
      });

      return menu;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('update menu'),
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
          } else if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}',
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('menu code : ${menu?.menuCode}'),
                Text('menu name (now) : ${menu?.menuName}'),
                TextField(
                  controller: _menuNameController,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(hintText: 'modifying menu name'),
                ),
                Text('menu price (now) : ${menu?.menuPrice}'),
                TextField(
                  controller: _menuPriceController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: 'modifying menu price'),
                ),
                Text('category code (now) : ${menu?.categoryCode}'),
                TextField(
                  controller: _categoryCodeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'modifying category code'),
                ),
                Text('orderable status now) : ${menu?.orderableStatus}'),
                TextField(
                  controller: _orderableStatusController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: 'modifying orderable status'),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _updateMenu();
        },
        icon: const Icon(Icons.update),
        label: Text('update'),
      ),
    );
  }

  void _updateMenu() async {
    var responses = await dio.put(baseUrl, data: {
      'menuCode': menu?.menuCode,
      'menuName': _menuNameController!.value.text,
      'menuPrice': _menuPriceController!.value.text,
      'categoryCode': _categoryCodeController!.value.text,
      'orderableStatus': _orderableStatusController!.value.text
    });

    Navigator.popAndPushNamed(context, '/selectmenubycode',
        arguments: responses.headers['location']![0]);
  }
}
