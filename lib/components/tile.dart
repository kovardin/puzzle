import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart' as pnt;

class Direction {
  Vector2 position;
  int direction;

  Direction({required this.position, required this.direction});
}

class TileComponent extends PositionComponent {
  Vector2? start = null;
  Vector2? velocity = null;
  Vector2? end = null;
  Direction? direction = null;

  final int value;

  TileComponent({required this.value});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    final style = pnt.TextStyle(color: BasicPalette.white.color, fontSize: 14);
    final regular = TextPaint(style: style);

    size = Vector2(50, 50);
    // anchor = Anchor.center;
    final paint = BasicPalette.red.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final square = RectangleComponent.square(
      size: 48.0,
      paint: paint,
    );

    add(square);
    add(TextComponent(text: '${value}', textRenderer: regular)
      ..anchor = Anchor.center
      ..x = 24
      ..y = 24);
  }
}
