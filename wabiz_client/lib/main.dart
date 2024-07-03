import 'package:flutter/material.dart';
import 'package:wabiz_client/router.dart';
import 'package:wabiz_client/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wabiz',
      theme: wabizDefaultTheme,
      routerConfig: router,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      themeAnimationStyle: AnimationStyle(
        curve: Curves.easeInCirc,
        duration: const Duration(milliseconds: 300)
      ),
    );
  }
}