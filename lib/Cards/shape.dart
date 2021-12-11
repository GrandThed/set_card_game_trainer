import 'package:flutter/material.dart';
import 'package:set_card_game_trainer/Cards/card_properties.dart';
import 'package:set_card_game_trainer/Cards/shape_generator.dart';

class CustomShape extends StatefulWidget {
  final CardProperties cardProperties;
  const CustomShape(
    this.cardProperties, {
    Key? key,
  }) : super(key: key);

  @override
  State<CustomShape> createState() => _CustomShapeState();
}

class _CustomShapeState extends State<CustomShape> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: SizedBox(
        height: 100,
        width: 200,
        child: CustomPaint(
          painter: ShapeGenerator(widget.cardProperties),
        ),
      ),
    );
  }
}
