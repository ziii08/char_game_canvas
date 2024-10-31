import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/cat_game.dart';

void main() {
  final game = CatGame();
  runApp(GameWidget(game: game));
}
