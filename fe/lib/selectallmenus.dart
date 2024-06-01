import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SelectAllMenus extends StatefulWidget {
  const SelectAllMenus({super.key});

  @override
  State<SelectAllMenus> createState() => _SelectAllMenusState();
}

class _SelectAllMenusState extends State<SelectAllMenus> {
  List? menus; // 결과 데이터를 저장할 리스트
  final dio = Dio();
  final url = 'http://10.0.2.2:8080/menus';

  @override
  void initState() {
    super.initState();
    menus = new List.empty(growable: true);
  }

  Future<List?> _asyncMethod() async {
    final response = await dio.get(url);

    setState(() {
      menus = response.data['results']['menus'];
      // print(menus?[0]);
    });

    return menus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('select all menus'),
      ),
      body: FutureBuilder(
          future: _asyncMethod(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // data를 아직 받아 오지 못햇을 때 로딩 표시
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
            // error가 발생할 경우
            else if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
              );
            }
            // data를 정상적으로 받아올 때
            else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Row(children: [
                            Text('${snapshot.data?[index]['menuCode']}. '),
                            Text(snapshot.data?[index]['menuName']),
                          ]),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/selected', arguments: menus?[index]);
                      },
                    ),
                  );
                },
              );
            }
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final dio = Dio();
      //     var url = 'http://10.0.2.2:8080/menus';
      //     // flutter에서는 localhost 대신 10.0.2.2 사용
      //     Map<String, String> headers = {
      //       'Content-Type': 'application/json',
      //       'Accept': 'application/json',
      //     };
      //     print('pressed');
      //     // var uri = Uri.parse(url);
      //     // http.Response response = await http.get(uri);
      //     var response = await dio.get(url);
      //     // print(response);
      //     // print(response.body);
      //     // print(response.body.length);
      //     print(response.data);
      //
      //     // var dataConvertedToJSON = json.decode(response.body);
      //     // print(dataConvertedToJSON);
      //     // print(dataConvertedToJSON['results']);
      //     // print(dataConvertedToJSON['results']['menus']);
      //     // print(dataConvertedToJSON['results']['menus'][20]);
      //     print(response.data['results']);
      //     print(response.data['results']['menus']);
      //     print(response.data['results']['menus'][20]);
      //     print(response.data['results']['menus'][20]['menuName']);
      //   },
      //   child: Icon(Icons.file_download),
      // ),
    );
  }
}
