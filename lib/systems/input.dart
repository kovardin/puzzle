import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:puzzle/components/tile.dart';

class InputSystem extends Component {
  Vector2? start;
  Vector2? velocity;
  Vector2? end;

  void onMouseMove(DragUpdateInfo info) {
    end = info.eventPosition.game;
  }

  @override
  bool onPanStart(DragStartInfo info) {
    start = info.eventPosition.game;
    return true;
  }

  @override
  bool onPanEnd(DragEndInfo info) {
    // update fisherman component
    velocity = info.velocity;
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (start != null && velocity != null && end != null) {

      var elements = parent!.children.query<TileComponent>();
      for (var element in elements) {
        if (tap(element.position, start!)) {
          element.start = start!;
          element.velocity = velocity!;
          element.end = end!;
          element.direction = direction(element.position, element.end!);
        }
      }

      start = null;
      velocity = null;
      end = null;
    }
  }

  bool tap(Vector2 pos, Vector2 tap) {
    return (tap.x > pos.x && tap.x < pos.x + 50 && tap.y > pos.y && tap.y < pos.y + 50);
  }

  Direction direction(Vector2 pos, Vector2 end) {
    // top = index - 4
    // bottom = index + 4;
    // left = index - 1;
    // right = index + 1;
    if (end.y > pos.y && end.x > pos.x && end.x < (pos.x + 50)) {
      return Direction(position: Vector2(0, 1), direction: 4);
    } else if (end.x > pos.x && end.y > pos.y && end.y < (pos.y + 50)) {
      return Direction(position: Vector2(1, 0), direction: 1);
    } else if (end.y < pos.y && end.x > pos.x && end.x < (pos.x + 50)) {
      return Direction(position: Vector2(0, -1), direction: -4);
    } else if (end.x < pos.x && end.y > pos.y && end.y < (pos.y + 50)) {
      return Direction(position: Vector2(-1, 0), direction: -1);
    }

    return Direction(position: Vector2(0, 0), direction: 0);
  }
}
