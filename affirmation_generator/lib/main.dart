import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Affirmation Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _affirmations = [
    "You are capable of achieving great things.",
    "Believe in yourself and all that you are.",
    "Every day is a new beginning.",
    "You have the power to create change.",
    "Embrace the journey and enjoy the ride."
  ];

  String _currentAffirmation = "Click the button to get an affirmation!";

  void _generateAffirmation() {
    final random = Random();
    setState(() {
      _currentAffirmation = _affirmations[random.nextInt(_affirmations.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Affirmation Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentAffirmation,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateAffirmation,
              child: const Text('Get Affirmation'),
            ),
          ],
        ),
      ),
    );
  }
}
