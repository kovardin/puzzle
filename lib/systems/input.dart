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
}
