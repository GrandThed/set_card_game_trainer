import 'package:flutter/material.dart';

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
    List<CardProperties> cards = [
      CardProperties(color: Colors.red.shade300, shape: 0, amout: 2, fill: 2),
      CardProperties(color: Colors.blue.shade300, shape: 1, amout: 2, fill: 2),
      CardProperties(color: Colors.green.shade300, shape: 2, amout: 2, fill: 2),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          for (var i = 0; i < cards.length; i++)
            SizedBox(width: width / cards.length, child: ShapeCard(cards[i])),
        ],
      ),
    );
  }
}

class CardProperties {
  final Color color;
  final int shape;
  final int amout;
  final int fill;

  const CardProperties(
      {required this.color,
      required this.shape,
      required this.amout,
      required this.fill})
      : super();
}

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
      color: Colors.blue.shade50,
      elevation: 3,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var i = 0; i < cardProperties.amout; i++)
                CustomShape(cardProperties)
            ],
          ),
        ),
      ),
    );
  }
}

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
          painter: HeaderPaintDiagonal(widget.cardProperties),
        ),
      ),
    );
  }
}

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
