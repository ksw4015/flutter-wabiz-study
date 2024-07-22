import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

final counterProvider = StateProvider((ref) => 0);

// Mockito
class Listener extends Mock {
  void call(int? previous, int value);
}

void main() {
  test('Riverpod StateProvider CounterProvider Test', () {
    final container = ProviderContainer();
    expect(container.read(counterProvider), equals(0));
  });

  // Mock Test
  group('Mock Test', () {
    test('initial value test', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final listener = Listener();
      container.listen(
          counterProvider,
          listener.call,
          fireImmediately: true
      );

      verify(listener(null, 0)).called(1);
      verifyNoMoreInteractions(listener);
    });

    test('increase value 1', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final listener = Listener();
      container.listen(
          counterProvider,
          listener.call,
          fireImmediately: true
      );

      verify(listener(null, 0)).called(1);
      verifyNoMoreInteractions(listener);

      container.read(counterProvider.notifier).state++;

      verify(listener(0, 1)).called(1);
      verifyNoMoreInteractions(listener);
    });
  });
}
