import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';

class TileComponent extends PositionComponent {
  Vector2? start = null;
  Vector2? velocity = null;
  Vector2? end = null;

  final int value;

  TileComponent({required this.value});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    size = Vector2(50, 50);
    // anchor = Anchor.center;
    final paint = BasicPalette.red.paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;
    final square = RectangleComponent.square(
      size: 48.0,
      paint: paint,
    );

    add(square);
    add(TextComponent(text: '${value}')
      ..anchor = Anchor.center
      ..x = 24
      ..y = 24);
  }
}
