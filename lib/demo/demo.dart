import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PositionedKey(),
    );
  }
}

class PositionedKey extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedKeyState();
}

class PositionedKeyState extends State<PositionedKey> {
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();
    tiles = [
      StatelessColorful(
          // key: UniqueKey(),
          ),
      StatelessColorful(
          // key: UniqueKey(),
          ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tiles,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTiles,
        child: const Icon(
          Icons.sentiment_very_satisfied,
        ),
      ),
    );
  }

  void swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

// class StatelessColorful extends StatefulWidget {
//   const StatelessColorful({required Key key}) : super(key: key);

//   @override
//   State<StatelessColorful> createState() => _StatelessColorfulState();
// }

// class _StatelessColorfulState extends State<StatelessColorful> {

class StatelessColorful extends StatelessWidget {
  StatelessColorful({super.key});

  final Color color = UniqueColorGenerator.getColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: const Padding(
        padding: EdgeInsets.all(70.0),
      ),
    );
  }
}

class UniqueColorGenerator {
  static Random random = Random();

  static Color getColor() {
    return Color.fromARGB(
      255,
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
    );
  }
}
