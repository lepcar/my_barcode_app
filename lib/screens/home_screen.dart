import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              'Welcome, User!', // Placeholder for logged-in user
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Find the AppShell state and tell it to switch tabs
                // We'll implement _AppShellState later in main.dart
                // For now, this shows the intent. A better way might involve
                // a shared state management solution later (Provider, Riverpod, etc.)
                DefaultTabController.of(context)?.animateTo(1); // Assuming Scanner is index 1
                // Note: This direct jump might be better handled via state management
              },
              child: const Text('Go to Scanner'),
            ),
            // We might need a more robust way to switch tabs from within a screen
            // later, possibly using a state management solution.
            // For now, this structure outlines the intent.
          ],
        ),
      ),
    );
  }
}