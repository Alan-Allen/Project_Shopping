import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_shopping/Routes/router.dart';
import 'package:project_shopping/component/Button.dart';

import '../DB/DBHelper.dart';
import '../DB/ShopList.dart';

class ShopPage extends StatefulWidget {
   const ShopPage({super.key});

  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  late List<ShopList> shops = [];

  @override
  void initState() {
    super.initState();
    getAll();
    getKeysFromDB();
  }

  void getKeysFromDB() async {
    DBHelper dbHelper = DBHelper();
    await dbHelper.initdb();
    List<ShopList> shopList = await dbHelper.getAll();
    setState(() {
      shops = shopList;
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
        title: const Text('購物清單 Shopping List'),
        actions: <Widget> [
          IconButton(
              onPressed: () {
                print('Refresh');
                getKeysFromDB();
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
                        List<ShopList> shopList = await getItem(search);
                        print(search);
                        setState(() {
                          shops = shopList;
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
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  if(index == 0) {
                    return Column(
                      children: [
                        _buildHeader(),
                        _buildItem(shops[index], context)
                      ],
                    );
                  } else {
                    return _buildItem(shops[index], context);
                  }
                }
              ),
            ),
            Center(
              child:
                CustomButton(
                    onPressed: () {
                      print('Insert Button Pressed');
                      _countController.clear();
                      _priceController.clear();
                      _itemController.clear();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Insert'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _countController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter count',
                                    label: const Text('數量'),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 3),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _priceController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter price',
                                    label: const Text('價格'),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 3),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _itemController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter item',
                                    label: const Text('品名'),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 3),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              CustomButton(
                                  onPressed: () {
                                    print('Close Button Pressed');
                                    Navigator.pop(context);
                                  },
                                  text: 'Close',
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  width: 15, height: 10
                              ),
                              CustomButton(
                                  onPressed: () {
                                    print('Insert Button Pressed');
                                    int count = int.parse(_countController.text);
                                    int price = int.parse(_priceController.text);
                                    String item = _itemController.text;
                                    insert(count, price, item);
                                    Navigator.pop(context);
                                    setState(() {
                                      getKeysFromDB();
                                    });
                                  },
                                  text: 'Insert',
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  width: 15, height: 10
                              ),
                            ],
                          );
                        }
                      );
                    },
                    text: "新增",
                    color: Colors.blue,
                    textColor: Colors.white,
                    width: 30,
                    height: 10
                )
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _buildItem(ShopList shops, BuildContext context) {
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
            flex: 1,
            child: Text(
              "${shops.count}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${shops.price}",
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
                  _itemController.text = shops.item;
                  _countController.text = "${shops.count}";
                  _priceController.text = "${shops.price}";
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Setting'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _countController,
                                decoration: InputDecoration(
                                  hintText: 'Enter count',
                                  label: const Text('數量'),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 3),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _priceController,
                                decoration: InputDecoration(
                                  hintText: 'Enter price',
                                  label: const Text('價格'),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 3),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _itemController,
                                decoration: InputDecoration(
                                  hintText: 'Enter item',
                                  label: const Text('品名'),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 3),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            CustomButton(
                              onPressed: () {
                                print('Update Button Pressed');
                                int count = int.parse(_countController.text);
                                int price = int.parse(_priceController.text);
                                String item = _itemController.text;
                                update(shops.id, count, price, item);
                                Navigator.of(context).pop();
                                setState(() {
                                  getKeysFromDB();
                                });
                              },
                              text: 'Update',
                              color: Colors.blue,
                              textColor: Colors.white,
                              width: 15,
                              height: 10,
                            ),
                            CustomButton(
                              onPressed: () {
                                print('Close Button Pressed');
                                Navigator.of(context).pop();
                              },
                              text: 'Close',
                              color: Colors.orange,
                              textColor: Colors.white,
                              width: 15,
                              height: 10,
                            ),
                            CustomButton(
                              onPressed: () {
                                print('Delete Button Pressed');
                                delete(shops.id);
                                Navigator.of(context).pop();
                                setState(() {
                                  getKeysFromDB();
                                });
                              },
                              text: 'Delete',
                              color: Colors.red,
                              textColor: Colors.white,
                              width: 15,
                              height: 10,
                            ),
                          ],
                        );
                      }
                  );
                },
                icon: const Icon(Icons.settings_outlined),
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
              Expanded(flex: 1, child: Text('數量', style: TextStyle(color: Colors.black, fontSize: 13))),
              SizedBox(width: 20),
              Expanded(flex: 1, child: Text('價格', style: TextStyle(color: Colors.black, fontSize: 13))),
              SizedBox(width: 20),
              Expanded(flex: 3, child: Text('品名', style: TextStyle(color: Colors.black, fontSize: 13))),
              SizedBox(width: 80),
              Expanded(flex: 2, child: Text('其他', style: TextStyle(color: Colors.black, fontSize: 13)))
        ],
      ),
    );
  }
}

void insert(int count, int price, String item) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  await dbHelper.Insert(count, price, item);
  print("Insert data: $count, $price, $item");
}

void getAll() async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<ShopList> shop = await dbHelper.getAll();
  print('Shop data: ');
  for(var shops in shop) {
    print('ID: ${shops.id}, Key: ${shops.item}');
  }
}

Future<List<ShopList>> getItem(String search) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<ShopList> shop = await dbHelper.getItem(search);
  print("get key data:");
  for(var key in shop) {
    print("ID: ${key.id}, count: ${key.count}, price: ${key.price}, item: ${key.item}");
  }
  return shop;
}

void update(int id, int count, int price, String item) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  ShopList shops = ShopList(id, count, item, price);
  await dbHelper.update(shops);
}

void delete(int id) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  await dbHelper.delete(id);
  print('delete $id');
}