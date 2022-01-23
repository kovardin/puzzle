class Puzzle {
  final Function success;

  Puzzle({required this.success});

  List<int> items = [];

  start() {
    for (var i = 0; i < 16; i++) {
      items.add(i + 1);
    }
    items[15] = 0;

    shuffle();
  }

  shuffle() {
    // items.shuffle();

    items[14] = 0;
    items[15] = 15;
  }

  bool can(int to) {
    if (to > 15 || to < 0) {
      return false;
    }

    if (items[to] > 0) {
      return false;
    }

    return true;
  }

  move(int from, int to) {
    var val = items[from];
    items[to] = val;
    items[from] = 0;
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
    success();
  }
}
