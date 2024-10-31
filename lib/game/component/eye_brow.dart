import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum Emotion { happy, sad, angry, surprised, neutral, focused }

class Eyebrow extends PositionComponent {
  @override
  final double width;
  @override
  final double height;
  Emotion emotion;
  final bool isLeft;

  Eyebrow({
    required this.width,
    required this.height,
    this.emotion = Emotion.neutral,
    required this.isLeft,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()..color = Colors.black;
    final rect =
        Rect.fromCenter(center: Offset.zero, width: width, height: height);

    canvas.save();
    _applyEmotionTransform(canvas);
    canvas.drawRect(rect, paint);
    canvas.restore();
  }

  void _applyEmotionTransform(Canvas canvas) {
    final rotationFactor = isLeft ? -1 : 1;

    switch (emotion) {
      case Emotion.happy:
        canvas.translate(0, -height / 2);
        canvas.rotate(rotationFactor * 0.2);
        break;
      case Emotion.angry:
        canvas.translate(0, height / 2);
        canvas.rotate(rotationFactor * -0.3);
        break;
      case Emotion.sad:
        canvas.translate(rotationFactor * -width / 4, -height / 2);
        canvas.rotate(rotationFactor * 0.3);
        break;
      case Emotion.surprised:
        canvas.translate(0, -height);
        canvas.rotate(rotationFactor * 0.1);
        break;
      case Emotion.focused:
        canvas.translate(rotationFactor * -width / 6, -height / 3);
        canvas.rotate(rotationFactor * 0.15);
        break;
      case Emotion.neutral:
      default:
        break;
    }
  }

  void setEmotion(Emotion newEmotion) {
    emotion = newEmotion;
  }
}
