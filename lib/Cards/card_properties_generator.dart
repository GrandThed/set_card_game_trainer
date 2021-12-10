import 'dart:math';

import 'package:set_card_game_trainer/Cards/card_properties.dart';
import 'package:flutter/material.dart';

class CardPropertiesGenerator {
  List<Color> availableColors = [
    Colors.red.shade300,
    Colors.purple.shade300,
    Colors.green.shade300
  ];
  List<CardProperties> getProperties(
      {required int amount, required int difficulty}) {
    // random generator
    Random random = Random();

    // helps choose randomly the variables that doesn't change
    List<int> randomPicker = List<int>.generate(4, (i) => i + 1)..shuffle();

    // variables of the cards
    Color? color;
    int? shape;
    int? amout;
    int? fill;

    List<CardProperties> listOfProperties = [];

    _setRandomValueToVariable(typeOfVariable) {
      switch (typeOfVariable) {
        // easy
        case "color":
          color = availableColors[random.nextInt(3)];
          break;
        // normal
        case "shape":
          shape = random.nextInt(3);
          break;
        // hard
        case "amount":
          amout = random.nextInt(3);
          break;

        case "fill":
          fill = random.nextInt(3);
          break;
        default:
      }
    }

    switch (difficulty) {
      case 3:
        // hard
        _setRandomValueToVariable(randomPicker[0]);
        continue normal;
      normal:
      case 2:
        _setRandomValueToVariable(randomPicker[1]);
        // normal
        continue easy;
      easy:
      case 1:
        // easy
        _setRandomValueToVariable(randomPicker[2]);
        break;
      default:
    }

    // generates n amount of cards properties
    for (var i = 0; i < amount; i++) {
      listOfProperties.add(CardProperties(
          // if the property isn't defined, generate it randomly
          color: color ?? availableColors[random.nextInt(3)],
          shape: shape ?? random.nextInt(3),
          amout: amout ?? random.nextInt(3) + 1,
          fill: fill ?? random.nextInt(3)));
    }
    return listOfProperties;
  }
}
