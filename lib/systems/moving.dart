import 'package:flame/components.dart';
import 'package:puzzle/components/tile.dart';
import 'package:puzzle/puzzle/puzzle.dart';

class Direction {
  Vector2 position;
  int direction;

  Direction({required this.position, required this.direction});
}

class MovingSystem extends Component {
  final Puzzle puzzle;

  MovingSystem({required this.puzzle}) : super();

  @override
  void update(double dt) {
    super.update(dt);

    var elements = parent!.children.query<TileComponent>();
    for (var element in elements) {
      if (element.start != null && element.velocity != null && element.end != null) {
        // calculate direction
        var d = direction(element.position, element.end!);

        // calculate from and to index
        var from = puzzle.items.indexOf(element.value);
        var to = from + d.direction;

        // check if we can move from current index to calculated
        if (!puzzle.can(to)) {
          return;
        }

        // move item
        element.position.add(d.position);
        puzzle.move(from, to);
        if (puzzle.check()) {
          puzzle.finish();
        }

        // clean moving data
        element.start = null;
        element.velocity = null;
        element.end = null;
      }
    }
  }

  Direction direction(Vector2 pos, Vector2 end) {
    // top = index - 4
    // bottom = index + 4;
    // left = index - 1;
    // right = index + 1;
    if (end.y > pos.y && end.x > pos.x && end.x < (pos.x + 50)) {
      return Direction(position: Vector2(0, 50), direction: 4);
    } else if (end.x > pos.x && end.y > pos.y && end.y < (pos.y + 50)) {
      return Direction(position: Vector2(50, 0), direction: 1);
    } else if (end.y < pos.y && end.x > pos.x && end.x < (pos.x + 50)) {
      return Direction(position: Vector2(0, -50), direction: -4);
    } else if (end.x < pos.x && end.y > pos.y && end.y < (pos.y + 50)) {
      return Direction(position: Vector2(-50, 0), direction: -1);
    }

    return Direction(position: Vector2(0, 0), direction: 0);
  }
}
