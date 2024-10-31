import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'component/face.dart';
import 'component/food.dart';

class CatGame extends FlameGame with TapDetector {
  late Face face;
  final List<Food> foodItems = [];
  late TextComponent catWeight;

  @override
  Future<void> onLoad() async {
    face = Face()
      ..position = size / 2
      ..anchor = Anchor.center;

    foodItems.addAll([
      Food(foodType: 'food1', position: Vector2(30, size.y - 100)),
      Food(foodType: 'food2', position: Vector2(130, size.y - 100)),
      Food(foodType: 'food3', position: Vector2(230, size.y - 100)),
      Food(foodType: 'food4', position: Vector2(330, size.y - 100)),
    ]);
    addAll([
      face,
      ...foodItems,
      catWeight = buildCatHeight(),
    ]);
  }

  TextComponent buildCatHeight() {
    return TextComponent(
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 40,
            fontFamily: 'Game',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ));
  }

  @override
  void onTapDown(TapDownInfo info) {
    final target = info.eventPosition.global;
    face.leftEye.lookAt(target);
    face.rightEye.lookAt(target);
  }

  @override
  void update(double dt) {
    super.update(dt);
    catWeight.text = 'Weight: ${face.catWeight}';
  }
}
