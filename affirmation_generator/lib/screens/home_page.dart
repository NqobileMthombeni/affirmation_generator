import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';  // Fixed import

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
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
  List<String> _favoriteAffirmations = [];
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _loadDarkModePreference();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteAffirmations = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> _loadDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteAffirmations);
  }

  Future<void> _saveDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
  }

  void _generateAffirmation() {
    final random = Random();
    setState(() {
      _currentAffirmation = _affirmations[random.nextInt(_affirmations.length)];
      _animationController.reset();
      _animationController.forward();
    });
  }

  void _toggleFavorite() {
    setState(() {
      if (_favoriteAffirmations.contains(_currentAffirmation)) {
        _favoriteAffirmations.remove(_currentAffirmation);
      } else {
        _favoriteAffirmations.add(_currentAffirmation);
      }
      _saveFavorites();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daily Affirmations'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                  _saveDarkModePreference();
                });
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: _isDarkMode
                  ? [Colors.grey[900]!, Colors.grey[800]!]
                  : [Colors.blue[100]!, Colors.blue[50]!],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FadeTransition(
                        opacity: _animation,
                        child: Text(
                          _currentAffirmation,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _generateAffirmation,
                        icon: const Icon(Icons.refresh),
                        label: const Text('New Affirmation'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: Icon(
                          _favoriteAffirmations.contains(_currentAffirmation)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: _toggleFavorite,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Favorite Affirmations'),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _favoriteAffirmations.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_favoriteAffirmations[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _favoriteAffirmations.removeAt(index);
                              _saveFavorites();
                            });
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.list),
        ),
      ),
    );
  }
}