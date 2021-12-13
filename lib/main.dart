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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<CardProperties> cards = CardPropertiesGenerator()
        .getProperties(amountOfCards: 3, difficulty: 1);

    // this is to force half of the times the set is true
    // it may be to brute, but i'm not that good doing algorithms
    while (ValidityChecker().checkList(cards) == Random().nextBool()) {
      cards = CardPropertiesGenerator()
          .getProperties(amountOfCards: 3, difficulty: 2);
    }

    String validity = ValidityChecker().checkList(cards).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(validity),
          Row(
            children: [
              for (var i = 0; i < cards.length; i++)
                SizedBox(
                    height: 550,
                    width: width / cards.length,
                    child: ShapeCard(cards[i])),
            ],
          ),
        ],
      ),
    );
  }
}
