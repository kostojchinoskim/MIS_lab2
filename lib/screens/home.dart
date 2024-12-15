import 'package:flutter/material.dart';
import 'package:mislab2/screens/random_joke.dart';
import '../services/api_services.dart';
import '../widgets/home/joke_type_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<String>> jokeTypes;

  @override
  void initState() {
    super.initState();
    jokeTypes = apiService.fetchJokeTypes();
  }

  // Function to fetch a random joke and navigate to RandomJokeScreen
  void _navigateToRandomJoke() async {
    final randomJoke = await apiService.fetchRandomJoke();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RandomJokeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes API 206014'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: _navigateToRandomJoke, // Navigate to random joke
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final types = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0), // Padding around the body
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  const Text(
                    'Select a joke type:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10), // Spacing between the label and the list
                  Expanded(
                    child: ListView.builder(
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        return JokeTypeCard(
                          jokeType: types[index],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/jokes',
                              arguments: types[index],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No joke types found.'));
          }
        },
      ),
    );
  }
}