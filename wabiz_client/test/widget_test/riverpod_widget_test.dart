import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final widgetCounterProvider = StateProvider(
    (ref) => 0
);

class MyTestRiverpodWidget extends StatelessWidget {

  const MyTestRiverpodWidget({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer(
        builder: (context, ref, child) {
          final counter = ref.watch(widgetCounterProvider);
          return ElevatedButton(
            onPressed: () {
              ref.read(widgetCounterProvider.notifier).state++;
            },
            child: Text("$counter"),
          );
        },
      ),
    );
  }
}

void main() {
  testWidgets('riverpod 위젯 테스트', (tester) async {
    await tester.pumpWidget(
        ProviderScope(
            child: MyTestRiverpodWidget()
        )
    );

    expect(find.text('0'), findsOneWidget);
    // Tap 액션
    await tester.tap(find.byType(ElevatedButton));
    // setState (Rebuild)
    await tester.pump();
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}