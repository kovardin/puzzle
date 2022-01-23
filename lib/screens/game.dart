import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:puzzle/puzzle/game.dart';

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
