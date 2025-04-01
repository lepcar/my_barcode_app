import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // Define a final callback variable
  final VoidCallback onNavigateToScanner; // VoidCallback is shorthand for Function()

  // Update the constructor to accept the callback
  const HomeScreen({
    super.key,
    required this.onNavigateToScanner, // Make it required
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome, User!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              // Use the passed-in callback directly
              onPressed: onNavigateToScanner,
              child: const Text('Go to Scanner'),
            ),
          ],
        ),
      ),
    );
  }
}