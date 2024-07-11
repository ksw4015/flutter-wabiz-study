import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wabiz_client/view/category/category_page.dart';
import 'package:wabiz_client/view/home/home_page.dart';
import 'package:wabiz_client/view/login/sign_in_page.dart';
import 'package:wabiz_client/view/login/sign_up_page.dart';
import 'package:wabiz_client/view/my/my_page.dart';
import 'package:wabiz_client/view/project/add_project_page.dart';
import 'package:wabiz_client/view/project/add_reward_page.dart';
import 'package:wabiz_client/view/wabiz_app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    // ShellRouter에 속하지 않음.
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return SignInPage();
      },
    ),
    GoRoute(
      path: '/sign-up',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return SignUpPage();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return WabizAppShell(
          currentIndex: switch(state.uri.path) {
            var path when path.startsWith('/my') => 3,
            _ => 0
          },
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
                return CategoryPage(categoryId: id ?? '0');
              },
            ),
          ]
        ),
        GoRoute(
          path: '/my',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return const MyPage();
          },
        )
      ],
    ),
    GoRoute(
      path: '/add',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return AddProjectPage();
      },
      routes: [
        GoRoute(
          path: 'reward/:id',
          builder: (context, state) {
            final projectId = state.extra as String;
            return AddRewardPage(projectId: projectId);
          },
        )
      ]
    )
  ]
);