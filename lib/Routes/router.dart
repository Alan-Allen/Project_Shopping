import 'package:go_router/go_router.dart';
import 'package:project_shopping/Pages/ShopPage.dart';

import '../Pages/HomePage.dart';

final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/shop',
        builder: (context, state) => const ShopPage(),
      ),
      GoRoute(
        path: '/cal',
        builder: (context, state) => const HomePage(),
      ),
    ]
);