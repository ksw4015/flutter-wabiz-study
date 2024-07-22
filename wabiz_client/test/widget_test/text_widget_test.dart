import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('텍스트 위젯 테스트', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('A'),
      ),
    ));

    expect(find.text('A'), findsOneWidget);
  });

  testWidgets('Key로 위젯 찾기', (tester) async {
    const key = Key('Key');
    await tester.pumpWidget(MaterialApp(
      key: key,
      home: Scaffold(

      ),
    ));

    expect(find.byKey(key), findsOneWidget);
  });
}