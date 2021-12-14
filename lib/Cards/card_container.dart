import 'package:flutter/material.dart';
import 'package:set_card_game_trainer/Cards/card_properties.dart';
import 'package:set_card_game_trainer/Cards/shape.dart';

class ShapeCard extends StatelessWidget {
  final CardProperties cardProperties;
  const ShapeCard(
    this.cardProperties, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      color: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var i = 0; i < cardProperties.amount; i++)
                CustomShape(cardProperties)
            ],
          ),
        ),
      ),
    );
  }
}
