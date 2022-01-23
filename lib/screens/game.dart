import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:puzzle/puzzle/puzzle.dart';
import 'package:puzzle/systems/input.dart';
import 'package:puzzle/systems/moving.dart';
import 'package:puzzle/systems/spawn.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late PuzzleGame puzzle;

  @override
  void initState() {
    super.initState();
    puzzle = PuzzleGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF231D29),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              // fit: StackFit.expand,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: GameWidget(
                    backgroundBuilder: (context) {
                      return Container(color: Color(0xFF231D29));
                    },
                    game: puzzle,
                    overlayBuilderMap: {
                      'PauseMenu': (ctx, game) {
                        return Center(
                          child: Container(
                            // alignment: Alignment.center,
                            child: Text('Success!', style: TextStyle(color: Colors.white, fontSize: 24)),
                          ),
                        );
                      },
                    },
                    // initialActiveOverlays: const ['PauseMenu'],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PuzzleGame extends FlameGame with PanDetector, TapDetector {
  PuzzleGame() {
    puzzle = Puzzle(success: () {
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
