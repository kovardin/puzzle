class PuzzleLogic {
  final Function success;
  final Function update;
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
