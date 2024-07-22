import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

final counterProvider = StateProvider(
      (ref) => 0,
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
          final counter = ref.watch(counterProvider);
          return Center(
            child: ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text("$counter"),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  // Integration Test Init
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Test Group
  group('Integration Test', () {
    testWidgets('Test Simple Counter', (tester) async {
      await tester.pumpWidget(ProviderScope(child: MyTestRiverpodWidget(),));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      await Future.delayed(Duration(seconds: 2));

      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });
  });
}