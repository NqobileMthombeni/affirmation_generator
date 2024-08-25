import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _affirmations = [
    "You are capable of achieving great things.",
    "Believe in yourself and all that you are.",
    "Every day is a new beginning.",
    "You have the power to create change.",
    "Embrace the journey and enjoy the ride.",
    "Everyday is a new beginning",
    "Perseverance flows through my veins, propelling me forward with unwavering resolve.",
    "I believe in my ability to persevere and create the life I desire.",
    "Each setback is a stepping stone on my path to greatness.",
    "I possess the inner strength and courage to persevere in the face of uncertainty.",
    "I am steadfast in my commitment to achieving my goals.",
    "Perseverance fuels my progress and propels me towards success.",
    "I am capable of persevering through any adversity that comes my way.",
    "I embrace obstacles as opportunities to prove my perseverance.",
    "With each challenge I face, my determination grows stronger.",
    "I am a resilient soul, and perseverance is my guiding force."
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
        title: Text('Affirmation Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentAffirmation,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateAffirmation,
              child: Text('Get Affirmation'),
            ),
          ],
        ),
      ),
    );
  }
}
