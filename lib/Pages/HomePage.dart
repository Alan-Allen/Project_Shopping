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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '選擇功能\nChoose Function',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            CustomButton(
                onPressed: () {
                  print('Shopping Page Button Pressed');
                  router.go('/shop');
                },
                text: '購物清單\nShopping List',
                color: Colors.blue,
                textColor: Colors.white,
                width: 23, height: 15
            ),
            const SizedBox(height: 30),
            CustomButton(
                onPressed: () {
                  print('calculation Page Button Pressed');
                  router.go('/cal');
                },
                text: '商品價格計算\ncalculation',
                color: Colors.orange,
                textColor: Colors.white,
                width: 23, height: 15
            ),
          ],
        ),
      ),
    );
  }
}