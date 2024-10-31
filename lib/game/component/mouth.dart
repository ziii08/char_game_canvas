import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:learn_flame/game/component/eye_brow.dart';

import '../cat_game.dart';

class Mouth extends PositionComponent with HasGameRef<CatGame> {
  @override
  final double width;
  @override
  final double height;

  bool isEating = false;
  double chewingTimer = 0;
  double chewDuration = 0.2;

  bool isCloseFood = false;
  bool isHappy = false;
  bool isNeutral = true;
  bool isSad = false;

  Mouth({required this.width, required this.height});

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    double arcHeight;

    if (isCloseFood) {
      paint.style = PaintingStyle.fill;
      arcHeight = height / 2;
    } else if (isEating) {
      paint.style = PaintingStyle.fill;
      arcHeight =
          height / 2 + sin(chewingTimer * pi * 2 / chewDuration) * (height / 4);
    } else if (isHappy) {
      arcHeight = height / 1.8;
    } else if (isSad) {
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 2;
      arcHeight = height / 2;
    } else {
      arcHeight = height / 8;
    }

    final rect =
        Rect.fromLTWH(-width / 2, height / 2 - arcHeight, width, arcHeight * 2);

    canvas.drawArc(
      rect,
      isSad && !isEating && !isCloseFood ? pi : 0,
      pi,
      false,
      paint,
    );
  }

  void mangap() {
    isCloseFood = true;
  }

  void startEating() {
    isCloseFood = false;
    isEating = true;
    chewingTimer = 0;
  }

  void expressHappy() {
    isHappy = true;
    isNeutral = false;
    isSad = false;
  }

  void expressSad() {
    isSad = true;
    isHappy = false;
    isNeutral = false;
  }

  void expressNeutral() {
    isNeutral = true;
    isHappy = false;
    isSad = false;
  }

  void checkExpression() {
    if (gameRef.face.catWeight <= 15) {
      expressSad();
      gameRef.face.setEyebrowEmotion(Emotion.sad);
    } else if (gameRef.face.catWeight <= 20) {
      expressNeutral();
      gameRef.face.setEyebrowEmotion(Emotion.neutral);
    } else {
      expressHappy();
      gameRef.face.setEyebrowEmotion(Emotion.happy);
    }
  }

  @override
  void update(double dt) {
    if (isEating) {
      chewingTimer += dt;

      if (chewingTimer > 2.0) {
        isEating = false;
        chewingTimer = 0;
      }
    }
    super.update(dt);
  }
}
