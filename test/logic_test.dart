import 'dart:math';

import 'package:puzzle/puzzle/logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Shuffle should be shuffle', () {
    final logic = PuzzleLogic(success: () {}, update: () {});

    for (var i = 0; i < 16; i++) {
      logic.items.add(i + 1);
    }
    logic.items[15] = 0;

    logic.shuffle();

    print(logic.items);
  });
}
