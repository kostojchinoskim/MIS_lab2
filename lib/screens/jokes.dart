import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';
import '../widgets/joke/joke_card.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Joke>> jokes;
  late String jokeType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the joke type passed in the route arguments
    final type = ModalRoute.of(context)?.settings.arguments as String;
    jokeType = type[0].toUpperCase() + type.substring(1); // Capitalize the first letter
    jokes = apiService.fetchJokesByType(type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$jokeType Jokes'), // Display the joke type in the AppBar
      ),
      body: FutureBuilder<List<Joke>>(
        future: jokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return JokeCard(joke: jokes[index]);
              },
            );
          } else {
            return const Center(child: Text('No jokes available.'));
          }
        },
      ),
    );
  }
}