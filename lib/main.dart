import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/jokes.dart';
import 'screens/random_joke.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokes API 206014',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/jokes': (context) => const JokesScreen(),
        '/random_joke': (context) => const RandomJokeScreen(),
      },
    );
  }
}