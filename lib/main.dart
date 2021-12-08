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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CustomShape(
              fill: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShape extends StatefulWidget {
  final int fill;
  const CustomShape({
    required this.fill,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomShape> createState() => _CustomShapeState();
}

class _CustomShapeState extends State<CustomShape> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < 7; i++)
          Center(
            child: SizedBox(
              height: 200 - i * 20,
              width: 100 - i * 10,
              child: CustomPaint(
                painter: HeaderPaintDiagonal(fill: widget.fill, shape: 0),
              ),
            ),
          )
      ],
    );
  }
}

class HeaderPaintDiagonal extends CustomPainter {
  final int fill;
  final int shape;

  const HeaderPaintDiagonal({
    required this.fill,
    required this.shape,
  }) : super();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.shade200
      ..style = fill == 0 ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path()
      ..arcToPoint(
        Offset(
          size.width * 1,
          size.height * 0,
        ),
        radius: Radius.circular(size.height * .05),
        largeArc: true,
      )
      ..lineTo(size.width, size.height * .5)
      ..arcToPoint(
        Offset(
          size.width * 0,
          size.height * .5,
        ),
        radius: Radius.circular(size.height * .05),
        largeArc: true,
      )
      ..close();

    // var customFill = fill == 2 ? 6 : 1;

    // for (var i = 0; i < customFill; i++) {
    //   double h = i / 10;
    //   path.addPolygon(
    //       SelectCustomShape(multiplier: h, size: size).rhombus(), true);
    // }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SelectCustomShape {
  final double multiplier;
  final dynamic size;
  const SelectCustomShape({required this.multiplier, required this.size})
      : super();

  List<Offset> rhombus() {
    return [
      Offset(size.width * 0.5, size.height * (0 + multiplier)),
      Offset(size.width * (0 + multiplier), size.height * 0.5),
      Offset(size.width * 0.5, size.height * (1 - multiplier)),
      Offset(size.width * (1 - multiplier), size.height * 0.5),
    ];
  }
}
