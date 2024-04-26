import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_shopping/Routes/router.dart';
import 'package:project_shopping/component/Button.dart';

import '../DB/ShopList.dart';
import '../component/Button.dart';

class ShopPage extends StatefulWidget {
   const ShopPage({super.key});

  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();

  late List<ShopList> shops = [];
  List<String> titleList = ['ID', 'Item', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            print('Back to home');
            router.go('/');
          },
        ),
        title: const Text('ShopList'),
        actions: <Widget> [
          IconButton(
              onPressed: () {
                print('Refresh');
              },
              icon: const Icon(Icons.refresh)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Enter Search',
                          label: const Text('Search'),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3),
                            borderRadius: BorderRadius.circular(15.0),
                          )
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                      onPressed: () {
                        print('Search button pressed');
                        String search = _searchController.text;
                        _searchController.clear();
                        print(search);
                      },
                      text: 'Search',
                      color: Colors.blue,
                      textColor: Colors.white,
                      width: 10, height: 10
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ListView.builder(
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  if(index == 0) {
                    return Column(
                      children: [
                        _buildHeader(),

                      ],
                    );
                  } else {

                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(ShopList shops) {
    return const Padding(padding: EdgeInsets.all(8.0));
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Expanded(child: Text('ID', style: TextStyle(color: Colors.black, fontSize: 13))),
        Expanded(child: Text('Item', style: TextStyle(color: Colors.black, fontSize: 13))),
        Expanded(child: Text('Other', style: TextStyle(color: Colors.black, fontSize: 13))),
      ]
    );
  }
}