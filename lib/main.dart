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
            Spacer(),
            CustomShape(
              fill: 2,
              shape: 0,
            ),
            Spacer(),
            CustomShape(
              fill: 2,
              shape: 2,
            ),
            Spacer(),
            CustomShape(
              fill: 2,
              shape: 1,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class CustomShape extends StatefulWidget {
  final int fill;
  final int shape;
  const CustomShape({
    required this.fill,
    required this.shape,
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
        painter: HeaderPaintDiagonal(fill: widget.fill, shape: widget.shape),
      ),
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

    final path = Path();
    switch (shape) {
      case 0:
        for (var i = 0; i < 6; i++) {
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
        for (var i = 0; i < 8; i++) {
          double h = i / 10;
          path.addRRect(RRect.fromRectAndRadius(
              Rect.fromLTWH(size.width * (h / 2), size.height * (h / 2),
                  size.width * (1 - h), size.height * (1 - h)),
              Radius.circular(size.height / 2)));
        }

        break;
      case 2:
        for (var i = 0; i < 8; i++) {
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
