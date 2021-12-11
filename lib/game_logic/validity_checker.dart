import 'package:flutter/material.dart';
import 'package:set_card_game_trainer/Cards/card_properties.dart';

class ValidityChecker {
  bool check(List<CardProperties> cardsProperties) {
    List<int> everyShape = [];
    List<Color> everyColor = [];
    List<int> everyFill = [];
    List<int> everyAmount = [];

    for (var e in cardsProperties) {
      everyShape.add(e.shape);
      everyColor.add(e.color);
      everyFill.add(e.fill);
      everyAmount.add(e.amount);
    }

    return false;
  }
}
