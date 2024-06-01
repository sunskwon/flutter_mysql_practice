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
        title: Text('insert menu'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('menu name : '),
          TextField(
            controller: _menuNameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(hintText: '메뉴 이름을 입력하세요'),
          ),
          Text('menu price : '),
          TextField(
            controller: _menuPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: '메뉴 가격을 입력하세요'),
          ),
          Text('category code : '),
          TextField(
            controller: _categoryCodeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: '메뉴 분류 번호를 입력하세요'),
          ),
          Text('orderable status : '),
          TextField(
            controller: _orderableStatusController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(hintText: '주문 가능 여부를 입력하세요'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _insertMenu();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _insertMenu() async {
    // print(_menuNameController!.value.text);
    // print(_menuPriceController!.value.text);
    // print(_categoryCodeController!.value.text);
    // print(_orderableStatusController!.value.text);

    String requestUrl = baseUrl + '/menus';

    var respones = await dio.post(requestUrl, data: {'menuCode': 0, 'menuName': _menuNameController!.value.text, 'menuPrice': _menuPriceController!.value.text, 'categoryCode': _categoryCodeController!.value.text, 'orderableStatus': _orderableStatusController!.value.text});

    // print(respones);
    // print(respones.runtimeType);
    // print(respones.data);
    // print(respones.headers);
    // print(respones.headers['location']);
    // print(respones.headers['location']?[0]);
    // print(respones.requestOptions);
    // print(respones.statusCode);

    print(baseUrl + respones.headers['location']![0]);
    Navigator.popAndPushNamed(context, '/selectmenubycode', arguments: respones.headers['location']![0]);
    // Navigator.popAndPushNamed(context, '/selectmenubycode', arguments: '/menus/1');
  }
}
