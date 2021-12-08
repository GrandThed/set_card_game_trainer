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
              fill: 0,
            ),
            CustomShape(
              fill: 1,
            ),
            CustomShape(
              fill: 2,
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
    return SizedBox(
      height: 200,
      width: 100,
      child: CustomPaint(
        painter: HeaderPaintDiagonal(fill: widget.fill),
      ),
    );
  }
}

class HeaderPaintDiagonal extends CustomPainter {
  final int fill;
  const HeaderPaintDiagonal({
    required this.fill,
  }) : super();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.shade200
      ..style = fill == 0 ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 5;

    final path = Path();

    var customFIll = fill == 2 ? 6 : 1;

    for (var i = 0; i < customFIll; i++) {
      double h = i / 10;
      path.addPolygon([
        Offset(size.width * 0.5, size.height * (0 + h)),
        Offset(size.width * (0 + h), size.height * 0.5),
        Offset(size.width * 0.5, size.height * (1 - h)),
        Offset(size.width * (1 - h), size.height * 0.5),
      ], true);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
