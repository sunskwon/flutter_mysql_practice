import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class InsertMenu extends StatefulWidget {
  const InsertMenu({super.key});

  @override
  State<InsertMenu> createState() => _InsertMenuState();
}

class _InsertMenuState extends State<InsertMenu> {
  final dio = Dio();
  final baseUrl = 'http://10.0.2.2:8080';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('insert menu'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('menu name : '),
          TextField(
            controller: _menuNameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: '메뉴 이름을 입력하세요'),
          ),
          const Text('menu price : '),
          TextField(
            controller: _menuPriceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: '메뉴 가격을 입력하세요'),
          ),
          const Text('category code : '),
          TextField(
            controller: _categoryCodeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: '메뉴 분류 번호를 입력하세요'),
          ),
          const Text('orderable status : '),
          TextField(
            controller: _orderableStatusController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: '주문 가능 여부를 입력하세요'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _insertMenu();
        },
        icon: const Icon(Icons.add),
        label: Text('regist'),
      ),
    );
  }

  void _insertMenu() async {
    String requestUrl = '$baseUrl/menus';
    var respones = await dio.post(requestUrl, data: {
      'menuCode': 0,
      'menuName': _menuNameController!.value.text,
      'menuPrice': _menuPriceController!.value.text,
      'categoryCode': _categoryCodeController!.value.text,
      'orderableStatus': _orderableStatusController!.value.text
    });

    Navigator.popAndPushNamed(context, '/selectmenubycode',
        arguments: respones.headers['location']![0]);
  }
}
