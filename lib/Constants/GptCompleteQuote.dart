import 'package:flutter/material.dart';

class QuotesApp extends StatefulWidget {
  @override
  _QuotesAppState createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  List<String> _quotes = [
    'The only way to do great work is to love what you do.',
    'If you want to live a happy life, tie it to a goal, not to people or things.',
    'Success is not final, failure is not fatal: it is the courage to continue that counts.',
    'The only limit to our realization of tomorrow will be our doubts of today.',
    'Happiness is not something ready-made. It comes from your own actions.'
  ];

  List<String> _favourites = [];

  void _addToFavourites(int index) {
    setState(() {
      _favourites.add(_quotes[index]);
    });
  }

  void _removeFromFavourites(int index) {
    setState(() {
      _favourites.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              "Don't be pushed around by the fears in your mind. Be led by the dreams in your heart.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
