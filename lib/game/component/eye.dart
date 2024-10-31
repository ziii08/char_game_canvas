import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Eye extends PositionComponent with HasGameRef {
  final double eyeRadius;
  final double pupilRadius;
  Vector2 pupilPosition;
  Vector2 targetPosition;
  bool isLooking = false;

  late TimerComponent resetTimer;

  Eye({
    required this.eyeRadius,
    required this.pupilRadius,
  })  : pupilPosition = Vector2.zero(),
        targetPosition = Vector2.zero();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    resetTimer = TimerComponent(
      period: 2,
      repeat: true,
      onTick: () {
        targetPosition = Vector2.zero();
        isLooking = true;
      },
    );

    add(resetTimer);
  }

  @override
  void render(Canvas canvas) {
    final paintEye = Paint()..color = Colors.white;
    final paintPupil = Paint()..color = Colors.black;

    canvas.drawCircle(const Offset(0, 0), eyeRadius, paintEye);

    canvas.drawCircle(
        Offset(pupilPosition.x, pupilPosition.y), pupilRadius, paintPupil);
  }

  @override
  void lookAt(Vector2 target) {
    final relativeTarget = target - absolutePosition;

    final direction = relativeTarget.normalized();
    targetPosition = direction * (eyeRadius - pupilRadius);
    isLooking = true;

    resetTimer.timer.reset();
  }

  @override
  void update(double dt) {
    if (isLooking) {
      pupilPosition += (targetPosition - pupilPosition) * 5 * dt;

      if ((targetPosition - pupilPosition).length < 0.5) {
        pupilPosition = targetPosition;
        isLooking = false;
      }
    }
    super.update(dt);
  }
}
