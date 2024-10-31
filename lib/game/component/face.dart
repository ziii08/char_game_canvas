import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:learn_flame/game/component/nose.dart';

import '../cat_game.dart';
import 'ear.dart';
import 'eye.dart';
import 'eye_brow.dart';
import 'mouth.dart';

class Face extends PositionComponent with HasGameRef<CatGame> {
  late Eye leftEye, rightEye;
  late Ear leftEar, rightEar;
  late Eyebrow leftEyebrow, rightEyebrow;
  late Mouth mouth;
  late Nose nose;

  int catWeight = 10;

  Face() {
    leftEye = Eye(eyeRadius: 20, pupilRadius: 6)..position = Vector2(-25, -15);
    rightEye = Eye(eyeRadius: 20, pupilRadius: 6)..position = Vector2(25, -15);

    leftEar = Ear(width: 40, height: 50)
      ..position = Vector2(-50, -45)
      ..angle = -0.54;

    rightEar = Ear(width: 40, height: 50)
      ..position = Vector2(20, -65)
      ..angle = 0.60;

    leftEyebrow = Eyebrow(width: 25, height: 4, isLeft: true)
      ..position = Vector2(-25, -40);
    rightEyebrow = Eyebrow(width: 25, height: 4, isLeft: false)
      ..position = Vector2(25, -40);

    mouth = Mouth(width: 40, height: 20)..position = Vector2(0, 25);

    nose = Nose(nodeSize: 5)..position = Vector2(0, 10);

    add(leftEyebrow);
    add(rightEyebrow);
    add(leftEye);
    add(rightEye);
    add(leftEar);
    add(rightEar);
    add(mouth);
    add(nose);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paintHead = Paint()..color = Colors.orangeAccent;
    const headRadius = 65.0;

    canvas.drawCircle(Offset.zero, headRadius, paintHead);
  }

  void setEyebrowEmotion(Emotion newEmotion) {
    if (leftEyebrow.emotion != newEmotion ||
        rightEyebrow.emotion != newEmotion) {
      leftEyebrow.emotion = newEmotion;
      rightEyebrow.emotion = newEmotion;
      debugPrint("Emotion: $newEmotion"); // Only prints when emotion changes
    }
  }
}
