import 'dart:math';

class PuzzleLogic {
  final Function success;
  final Function update;
  Random random = Random(DateTime
      .now()
      .millisecondsSinceEpoch);
  int counter = 0;
  bool active = true;

  PuzzleLogic({required this.success, required this.update});

  List<int> items = [];

  start() {
    active = true;
    counter = 0;
    items = [];

    for (var i = 0; i < 16; i++) {
      items.add(i + 1);
    }
    items[15] = 0;

    shuffle();

    update();
  }

  // https://stackoverflow.com/questions/36593259/a-good-randomizer-for-puzzle-15
  // https://stackoverflow.com/questions/67955041/finding-a-random-permutation-of-sequence-1-15-for-the-15-puzzle-in-c
  shuffle() {
    for (var i = 0; i < 300; i++) {
      var hole = items.indexOf(0);

      var top = hole - 4;
      var bottom = hole + 4;
      var left = hole - 1;
      var right = hole + 1;

      var swaps = <int>[];
      if (can(top)) {
        swaps.add(top);
      }
      if (can(bottom)) {
        swaps.add(bottom);
      }
      if (hole % 4 != 0) {
        swaps.add(left);
      }
      if (hole % 4 != 3) {
        swaps.add(right);
      }

      if (swaps.length == 0) {
        continue;
      }
      var swap = swaps[random.nextInt(swaps.length)];
      move(hole, swap);
    }
    counter = 0;
  }

  bool can(int to) {
    if (to > 15 || to < 0) {
      return false;
    }

    return true;
  }

  move(int from, int to) {
    var tval = items[to];
    var fval = items[from];
    items[to] = fval;
    items[from] = tval;
    counter++;

    update();
  }

  check() {
    var prev = items.first;
    for (var next in items.getRange(1, items.length - 1)) {
      if (prev > next) {
        return false;
      }
    }

    return true;
  }

  finish() {
    active = false;
    success();

    update();
  }
}
