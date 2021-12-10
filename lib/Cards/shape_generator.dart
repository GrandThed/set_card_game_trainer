import 'package:flutter/material.dart';
import 'package:set_card_game_trainer/Cards/card_properties.dart';

class HeaderPaintDiagonal extends CustomPainter {
  final CardProperties cardProperties;

  const HeaderPaintDiagonal(this.cardProperties) : super();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = cardProperties.color
      ..style =
          cardProperties.fill == 0 ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 3;

    var fillCustom = cardProperties.fill == 2 ? 8 : 1;

    final path = Path();
    switch (cardProperties.shape) {
      case 0:
        for (var i = 0; i < fillCustom; i++) {
          double h = i / 10;
          path.addPolygon([
            Offset(size.width * 0.5, size.height * (0 + h)),
            Offset(size.width * (0 + h), size.height * 0.5),
            Offset(size.width * 0.5, size.height * (1 - h)),
            Offset(size.width * (1 - h), size.height * 0.5),
          ], true);
        }
        break;
      case 1:
        for (var i = 0; i < fillCustom; i++) {
          double h = i / 10;
          path.addRRect(RRect.fromRectAndRadius(
              Rect.fromLTWH(size.width * (h / 2), size.height * (h / 2),
                  size.width * (1 - h), size.height * (1 - h)),
              Radius.circular(size.height / 2)));
        }

        break;
      case 2:
        for (var i = 0; i < fillCustom; i++) {
          double h = i / 10;
          path.addRRect(RRect.fromRectAndRadius(
              Rect.fromLTWH(size.width * (h / 2), size.height * (h / 2),
                  size.width * (1 - h), size.height * (1 - h)),
              const Radius.circular(0)));
        }
        // path.addRRect(RRect.fromRectAndRadius(
        //     Rect.fromLTWH(0, 0, size.width, size.height),
        //     const Radius.circular(0)));
        break;
      default:
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
