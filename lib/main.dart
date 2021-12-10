import 'package:flutter/material.dart';
import 'package:set_card_game_trainer/Cards/card_container.dart';
import 'package:set_card_game_trainer/Cards/card_properties.dart';

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
