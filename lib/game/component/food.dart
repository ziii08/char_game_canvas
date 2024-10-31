import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:learn_flame/game/cat_game.dart';

import 'eye_brow.dart';

class Food extends SpriteComponent with HasGameRef<CatGame>, DragCallbacks {
  final String foodType;
  late Vector2 initialPosition;

  Food({
    required this.foodType,
    required Vector2 position,
  }) : super(position: position, size: Vector2(50, 50)) {
    initialPosition = position.clone();
  }

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('$foodType.png');
    size = size;
    position = position;
    super.onLoad();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    try {
      if ((gameRef.face.mouth.absolutePosition - position).length < 100) {
        gameRef.face.mouth.isCloseFood = true;
        gameRef.face.setEyebrowEmotion(Emotion.focused);
      } else {
        gameRef.face.mouth.isCloseFood = false;
        gameRef.face.mouth.checkExpression();
      }

      position.add(event.localDelta);

      game.face.leftEye.lookAt(position);
      game.face.rightEye.lookAt(position);
    } catch (e) {
      debugPrint("Error during onDragUpdate: $e");
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if ((gameRef.face.mouth.absolutePosition - position).length < 40) {
      gameRef.face.mouth.startEating();
      gameRef.face.catWeight += 5;
      removeFromParent();
    } else {
      gameRef.face.mouth.isCloseFood = false;
      gameRef.face.mouth.checkExpression();
      position = initialPosition.clone();
    }
  }
}
