import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:puzzle/puzzle/logic.dart';
import 'package:puzzle/systems/input.dart';
import 'package:puzzle/systems/moving.dart';
import 'package:puzzle/systems/spawn.dart';

class PuzzleGame extends FlameGame with PanDetector, TapDetector {
  PuzzleGame() {
    puzzle = PuzzleLogic(success: () {
      overlays.add('PauseMenu');
    });
  }

  // systems
  late final SpawnSystem spawn;
  late final MovingSystem moving;
  final input = InputSystem();

  // main logic
  late final puzzle;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    spawn = SpawnSystem(puzzle: puzzle);
    moving = MovingSystem(puzzle: puzzle);

    // systems
    await add(spawn);
    await add(input);
    await add(moving);

    // init game
    spawn.start();
    spawn.spawn();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    input.onMouseMove(info);
  }

  @override
  bool onPanStart(DragStartInfo info) {
    input.onPanStart(info);
    return true;
  }

  @override
  bool onPanEnd(DragEndInfo info) {
    input.onPanEnd(info);
    return true;
  }
}
