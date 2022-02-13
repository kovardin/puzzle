import 'package:flame/components.dart';
import 'package:puzzle/components/tile.dart';
import 'package:puzzle/puzzle/logic.dart';

class SpawnSystem extends Component {
  final PuzzleLogic puzzle;

  SpawnSystem({required this.puzzle}) : super();

  @override
  Future<void>? onLoad() async {
    parent?.children.register<TileComponent>();
    await super.onLoad();
  }

  void start() {
    puzzle.start();
  }

  void spawn() async {
    var cnt = 0;
    for (var i = 0; i < 4; i++) {
      for (var j = 0; j < 4; j++) {
        if (puzzle.items[cnt] == 0) {
          cnt++;
          continue;
        }

        var tile = TileComponent(value: puzzle.items[cnt])
          ..x = j * 52
          ..y = i * 52;

        // components
        await parent?.add(tile);

        cnt++;
      }
    }
  }

  void clear() {
    var elements = parent!.children.query<TileComponent>();
    for (var e in elements) {
      e.removeFromParent();
    }
  }
}
