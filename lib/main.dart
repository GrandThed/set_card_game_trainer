import 'dart:math';

import 'package:flutter/material.dart';
import 'package:set_card_game_trainer/Cards/card_container.dart';
import 'package:set_card_game_trainer/Cards/card_properties.dart';
import 'package:set_card_game_trainer/Cards/card_properties_generator.dart';
import 'package:set_card_game_trainer/game_logic/validity_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Sets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int difficulty = 2;
  List<CardProperties> cards =
      CardPropertiesGenerator().getProperties(amountOfCards: 3, difficulty: 2);

  // this is to force half of the times the set is true
  // it may be to brute, but i'm not that good doing algorithms

  @override
  void initState() {
    bool randomBool = Random().nextBool();
    while (!(ValidityChecker().checkList(cards) == randomBool)) {
      cards = CardPropertiesGenerator()
          .getProperties(amountOfCards: 3, difficulty: difficulty);
    }
    super.initState();
  }

  bool nextSet = true;
  void handlePress(String direction) {
    var posibleCard = cards = CardPropertiesGenerator()
        .getProperties(amountOfCards: 3, difficulty: difficulty);
    print(direction);
    nextSet = Random().nextBool();
    while (!(ValidityChecker().checkList(posibleCard) == nextSet)) {
      posibleCard = cards = CardPropertiesGenerator()
          .getProperties(amountOfCards: 3, difficulty: difficulty);
    }
    setState(() {
      cards = posibleCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    String validity = ValidityChecker().checkList(cards).toString();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(validity),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
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
                      handlePress("left");
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
                      handlePress("right");
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
