import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wabiz_client/view/category/category_page.dart';
import 'package:wabiz_client/view/home/home_page.dart';
import 'package:wabiz_client/view/wabiz_app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return WabizAppShell(
          currentIndex: 0,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return const HomePage();
          },
          routes: [
            GoRoute(
              path: 'category/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                print(id);
                return CategoryPage(categoryId: id ?? '0');
              },
            ),
          ]
        ),
      ],
    )
  ]
);