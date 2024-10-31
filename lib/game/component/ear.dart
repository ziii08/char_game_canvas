import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ear extends PositionComponent {
  @override
  final double width;
  @override
  final double height;

  Ear({required this.width, required this.height});

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.orange;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(width / 2, -height)
      ..lineTo(width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }
}
