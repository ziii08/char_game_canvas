import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Nose extends PositionComponent {
  final double nodeSize;

  Nose({required this.nodeSize});

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset.zero, nodeSize, paint);
  }

  void wiggle(Vector2 tapPosition) {
    // Hidung sedikit bergerak ke arah klik
    final dx = (tapPosition.x - position.x) * 0.02;
    final dy = (tapPosition.y - position.y) * 0.02;
    position.add(Vector2(dx, dy));
  }
}
