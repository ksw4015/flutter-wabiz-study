import 'package:flutter_test/flutter_test.dart';

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}

void main() {
  test('Counter increment()', () {
    final counter = Counter();
    counter.increment();
    expect(counter.value, 1);
  });

  // test group
  group('Counter class Test group', () {
    test('Counter init expect value 0', () {
      expect(Counter().value, 0);
    });
    test('Counter increment function expect value 1', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });
    test('Counter decrement function expect value 1', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value, 1);
    });
  });
}