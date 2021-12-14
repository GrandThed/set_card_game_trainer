import 'dart:math';

import 'package:flutter/material.dart';
import 'package:set_card_game_trainer/Cards/card_container.dart';
import 'package:set_card_game_trainer/Cards/card_properties.dart';
import 'package:set_card_game_trainer/Cards/card_properties_generator.dart';
import 'package:set_card_game_trainer/game_logic/options_constructor.dart';
import 'package:set_card_game_trainer/game_logic/validity_checker.dart';
import 'package:set_card_game_trainer/game_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final int defaultAmount = 3;
  final int defaultDifficulty = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(
          title: 'Sets',
          defaultAmount: defaultAmount,
          defaultDifficulty: defaultDifficulty),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.defaultDifficulty,
      required this.defaultAmount})
      : super(key: key);

  final String title;
  // not used yet
  final int defaultDifficulty;
  final int defaultAmount;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int points = 0;
  OptionsConstructor options =
      const OptionsConstructor(difficulty: 3, amountOfShapes: 3);

  DificultyLevels savedDifficulty = DificultyLevels.hard;

  List<CardProperties> cards =
      CardPropertiesGenerator().getProperties(amountOfCards: 3, difficulty: 2);

  @override
  void initState() {
    super.initState();
    while (!(ValidityChecker().checkList(cards) == true)) {
      cards = CardPropertiesGenerator().getProperties(
          amountOfCards: options.amountOfShapes,
          difficulty: options.difficulty);
    }
  }

  void handlePress(bool direction) {
    if (direction == ValidityChecker().checkList(cards)) {
      setState(() {
        points += 1;
      });
    } else {
      setState(() {
        points = 0;
      });
    }

    bool nextSet = true;
    var posibleCard = CardPropertiesGenerator().getProperties(
        amountOfCards: options.amountOfShapes, difficulty: options.difficulty);

    // this is to force that half of the times the set is true
    // it may be way too brute force, but i'm not that great at doing algorithms

    nextSet = Random().nextBool();
    while (!(ValidityChecker().checkList(posibleCard) == nextSet)) {
      posibleCard = CardPropertiesGenerator().getProperties(
          amountOfCards: options.amountOfShapes,
          difficulty: options.difficulty);
    }
    setState(() {
      cards = posibleCard;
    });
  }

  void handleOptionsChange(DificultyLevels difficulty) {
    savedDifficulty = difficulty;
    OptionsConstructor newOptions;
    switch (difficulty) {
      case DificultyLevels.superEasy:
        newOptions = const OptionsConstructor(difficulty: 1, amountOfShapes: 2);
        break;
      case DificultyLevels.easy:
        newOptions = const OptionsConstructor(difficulty: 1, amountOfShapes: 3);
        break;
      case DificultyLevels.normal:
        newOptions = const OptionsConstructor(difficulty: 2, amountOfShapes: 3);
        break;
      case DificultyLevels.hard:
        newOptions = const OptionsConstructor(difficulty: 3, amountOfShapes: 3);
        break;
      default:
        newOptions = options;
    }

    setState(() {
      points = 0;
      options = newOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    // String validity = ValidityChecker().checkList(cards).toString();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Options(
                handleOptionsChange: handleOptionsChange,
                savedDifficulty: savedDifficulty),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Text(validity),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Text(points.toString()),
                Row(
                  children: [
                    for (var i = 0; i < cards.length; i++)
                      SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: width / cards.length,
                          child: ShapeCard(cards[i])),
                  ],
                ),
                Row(children: [
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent)),
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height,
                      width: width / 3,
                    ),
                    onPressed: () {
                      handlePress(false);
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent)),
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height,
                      width: width / 3,
                    ),
                    onPressed: () {
                      handlePress(true);
                    },
                  )
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
