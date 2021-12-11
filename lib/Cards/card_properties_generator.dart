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
    List<int> randomPicker = List<int>.generate(3, (i) => i + 1)..shuffle();

    // variables of the cards
    Color? color;
    int? shape;
    int? amout;
    int? fill;

    List<CardProperties> listOfProperties = [];

    List<String> listOfAvailableProperties = [
      "color",
      "shape",
      "amout",
      "fill",
    ];

    _setRandomValueToVariable(typeOfVariable) {
      switch (listOfAvailableProperties[typeOfVariable]) {
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
      case 1:
        // easy
        _setRandomValueToVariable(randomPicker[0]);
        _setRandomValueToVariable(randomPicker[1]);
        _setRandomValueToVariable(randomPicker[2]);
        break;
      case 2:
        // normal
        _setRandomValueToVariable(randomPicker[0]);
        _setRandomValueToVariable(randomPicker[1]);
        break;
      case 3:
        // hard
        _setRandomValueToVariable(randomPicker[0]);
        break;
      default:
    }

    // both of the following functions are use on the for loop

    // generates n amount of cards properties
    CardProperties cardProperty() => CardProperties(
        // if the property isn't defined, generate it randomly
        color: color ?? availableColors[random.nextInt(3)],
        shape: shape ?? random.nextInt(3),
        amout: amout ?? random.nextInt(3) + 1,
        fill: fill ?? random.nextInt(3));

    bool checkIfNotCardOnList(
            List<CardProperties> listOfCards, CardProperties card) =>
        listOfCards.every((element) => !(card.shape == element.shape &&
            card.fill == element.fill &&
            card.color == element.color));

    for (var i = 0; i < amount; i++) {
      // REFACTOR THIS
      // there is no more corsed way to do the thing i want, but it's to late
      // check if the card properties are already included and create it again if it's
      bool isRepeated = true;
      while (isRepeated) {
        CardProperties posibleCard = cardProperty();
        if (checkIfNotCardOnList(listOfProperties, posibleCard)) {
          isRepeated = false;
          listOfProperties.add(posibleCard);
        }
      }
    }
    return listOfProperties;
  }
}
