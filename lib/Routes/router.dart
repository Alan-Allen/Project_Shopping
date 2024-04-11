import 'package:go_router/go_router.dart';

import '../Pages/HomePage.dart';

final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/shop',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/cal',
        builder: (context, state) => const HomePage(),
      ),
    ]
);