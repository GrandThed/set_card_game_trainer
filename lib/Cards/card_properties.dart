import 'package:flutter/material.dart';

class CardProperties {
  final Color color;
  final int shape;
  final int amount;
  final int fill;

  const CardProperties(
      {required this.color,
      required this.shape,
      required this.amount,
      required this.fill})
      : super();
}
