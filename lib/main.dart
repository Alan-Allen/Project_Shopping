import 'package:flutter/material.dart';
import 'package:project_shopping/DB/DBHelper.dart';
import 'package:project_shopping/Routes/router.dart';
import '../Funtion/mqtt.dart';

void main() async {
  runApp(const MyApp());
  DBHelper dbHelper = DBHelper();
  await dbHelper.deleteAll();
  await dbHelper.Insert(1, 10, '商品一');
  await dbHelper.Insert(2, 200, '商品二');
  await dbHelper.InsertItem('item1');
  await dbHelper.InsertItem('item2');
  await dbHelper.InsertItem('item3');
  await dbHelper.InsertItem('item4');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}