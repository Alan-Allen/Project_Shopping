import 'package:flutter/material.dart';

import '../Routes/router.dart';
import '../component/Button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              '賣場購物系統\nShopping System',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                CustomButton(
                    onPressed: () {
                      print('Shopping Page Button Pressed');
                      router.go('/shop');
                    },
                    text: '購物清單\nShopping List',
                    color: Colors.blue,
                    textColor: Colors.white,
                    width: 30, height: 15
                ),
                const SizedBox(height: 30),
                CustomButton(
                    onPressed: () {
                      print('calculation Page Button Pressed');
                      router.go('/nav');
                    },
                    text: '路線選擇\nProduct Directory',
                    color: Colors.orange,
                    textColor: Colors.white,
                    width: 18, height: 15
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}