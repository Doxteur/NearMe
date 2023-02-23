import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getwidget/getwidget.dart';

class APiCallTest extends StatefulWidget {
  const APiCallTest({super.key});

  @override
  State<APiCallTest> createState() => _APiCallTestState();
}

class _APiCallTestState extends State<APiCallTest> {
  Future<List> apiData = Future.value([]);
  Future<List> getApiData() async {
    var url = 'https://free-food-menus-api-production.up.railway.app/burgers';
    var response = await Dio().get(url);
    return response.data;
  }

  @override
  void initState() {
    apiData = getApiData();
    print(apiData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiData,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  // return Card(
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Text('${snapshot.data?[index]['name']}'),
                  //       Text('${snapshot.data?[index]['price']}'),
                  //       Text('${snapshot.data?[index]['dsc']}'),
                  //     ],
                  //   ),
                  // );
                  return GFListTile(
                      avatar: GFAvatar(
                        backgroundImage:
                            NetworkImage('${snapshot.data?[index]['img']}'),
                      ),
                      titleText: '${snapshot.data?[index]['name']}',
                      subTitleText:
                          '${snapshot.data?[index]['price']} ${snapshot.data?[index]['dsc']}',
                      icon: const Icon(Icons.favorite));
                });
          } else {
            return const Placeholder();
          }
        });
  }
}
