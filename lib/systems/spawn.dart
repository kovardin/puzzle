import 'package:flame/components.dart';
import 'package:puzzle/components/tile.dart';
import 'package:puzzle/puzzle/puzzle.dart';

class SpawnSystem extends Component {
  final Puzzle puzzle;

  SpawnSystem({required this.puzzle}) : super();

  @override
  Future<void>? onLoad() async {
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

        parent?.children.register<TileComponent>();
        var tile = TileComponent(value: puzzle.items[cnt])
          ..x = j * 50
          ..y = i * 50;

        // components
        await parent?.add(tile);

        cnt++;
      }
    }
  }
}
