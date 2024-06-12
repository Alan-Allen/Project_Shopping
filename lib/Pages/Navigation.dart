import 'package:flutter/material.dart';
import 'package:project_shopping/DB/ItemList.dart';
import '../Funtion/mqtt.dart';

import '../DB/DBHelper.dart';
import '../Routes/router.dart';
import '../component/Button.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState  extends State<NavigationPage> {
  final TextEditingController _searchController = TextEditingController();

  late List<ItemList> items = [];

  @override
  void initState() {
    super.initState();
    connect();
    getAll();
    getKeysFromDB();
  }

  void getKeysFromDB() async {
    DBHelper dbHelper = DBHelper();
    await dbHelper.initdb();
    List<ItemList> itemList = await dbHelper.getAllItem();
    setState(() {
      items = itemList;
    });
  }

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
        title: const Text('路線選擇 Product Directory'),
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
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
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
                      onPressed: () async {
                        print('Search button pressed');
                        String search = _searchController.text;
                        _searchController.clear();
                        List<ItemList> shopList = await getItem(search);
                        print(search);
                        setState(() {
                          items = shopList;
                        });
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
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    if(index == 0) {
                      return Column(
                        children: [
                          _buildHeader(),
                          _buildItem(items[index], context)
                        ],
                      );
                    } else {
                      return _buildItem(items[index], context);
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(ItemList shops, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "${shops.id}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              shops.item,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: IconButton(
                  onPressed: () {
                    print('Go');
                    String item = shops.item;
                    sendMessage('/home/test', item);
                  },
                  icon: const Icon(Icons.play_arrow_outlined),
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('ID', style: TextStyle(color: Colors.black, fontSize: 13))),
          SizedBox(width: 20),
          Expanded(flex: 3, child: Text('品名', style: TextStyle(color: Colors.black, fontSize: 13))),
          SizedBox(width: 80),
          Expanded(flex: 2, child: Text('開始導航', style: TextStyle(color: Colors.black, fontSize: 13)))
        ],
      ),
    );
  }
}

Future<List<ItemList>> getItem(String search) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<ItemList> shop = await dbHelper.getItem2(search);
  print("get key data:");
  for(var key in shop) {
    print("ID: ${key.id}, item: ${key.item}");
  }
  return shop;
}

void getAll() async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<ItemList> shop = await dbHelper.getAllItem();
  print('Item data: ');
  for(var shops in shop) {
    print('ID: ${shops.id}, Key: ${shops.item}');
  }
}