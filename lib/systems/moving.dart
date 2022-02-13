import 'dart:math';

import 'package:flame/components.dart';
import 'package:puzzle/components/tile.dart';
import 'package:puzzle/puzzle/logic.dart';

class MovingSystem extends Component {
  final PuzzleLogic puzzle;
  final double speed = 100.0;

  double _cnt = 0.001;

  MovingSystem({required this.puzzle}) : super();

  @override
  void update(double dt) {
    super.update(dt);

    if (!puzzle.active) {
      return;
    }

    var elements = parent!.children.query<TileComponent>();

    for (var element in elements) {
      if (element.direction != null) {
        // calculate from and to index
        var from = puzzle.items.indexOf(element.value);
        var to = from + element.direction!.direction;

        // check if we can move from current index to calculated
        if (!puzzle.can(to)) {
          return;
        }

        var a = 0.15;
        var w = 19.4;
        var t =  _cnt / 52;

        var s = -(pow(e, -t / a) * cos(t * w)) + 1;

        // https://medium.com/flutter-community/creating-animation-curves-in-flutter-4a1f9313a662

        var next = dt * s * speed;

        print(next);

        var dist = _cnt + next;
        if (dist > 52) {
          next = 52 - _cnt;
        }

        // move item
        element.position.add(element.direction!.position * next);

        _cnt = _cnt + next;

        // 52 - max move distance
        // finish move
        if (_cnt >= 52) {
          // clean moving data
          element.direction = null;
          _cnt = 0.001;

          // update game logic
          puzzle.move(from, to);
          if (puzzle.check()) {
            puzzle.finish();
          }
        }
      }
    }
  }
}
