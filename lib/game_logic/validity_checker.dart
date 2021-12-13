// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:set_card_game_trainer/Cards/card_properties.dart';

class ValidityChecker {
  bool checkList(List<CardProperties> cardsProperties) {
    // check if every variable is the same or fi non is equal and return
    // true if any of those cases and false otherwise
    bool checkValidity(List propertyList) {
      // for checking if all equal
      bool allEqual =
          propertyList.every((element) => propertyList[0] == element);
      // for checking if all unequal
      List<bool> allUnequalList = [];
      for (var i = 0; i < propertyList.length; i++) {
        allUnequalList
            .add(!propertyList.sublist(0, i).contains(propertyList[i]));
      }
      bool allUnequal = allUnequalList.every((element) => element);

      return allEqual || allUnequal;
    }

    // contains every x of all the cards
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

    bool isValidShape = checkValidity(everyShape);
    bool isValidColor = checkValidity(everyColor);
    bool isValidFill = checkValidity(everyFill);
    bool isValidAmount = checkValidity(everyAmount);

    return isValidShape && isValidColor && isValidFill && isValidAmount;
  }
}
