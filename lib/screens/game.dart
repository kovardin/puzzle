import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: PuzzleGame(),
    );
  }
}

class PuzzleGame extends FlameGame {
  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    add(Robo());
  }
}

class Robo extends SpriteComponent {
  // creates a component that renders the crate.png sprite, with size 16 x 16
  Robo() : super(size: Vector2.all(50));

  Future<void> onLoad() async {
    sprite = await Sprite.load('robo.jpeg');
    anchor = Anchor.center;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    // We don't need to set the position in the constructor, we can set it directly here since it will
    // be called once before the first time it is rendered.
    position = gameSize / 2;
  }
}
