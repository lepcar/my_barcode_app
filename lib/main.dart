import 'package:provider/provider.dart'; // Import Provider
import 'package:flutter/material.dart';

import 'app_state.dart';                // Import AppState
import 'screens/home_screen.dart';
import 'screens/scanner_screen.dart';
import 'screens/history_screen.dart';
import 'screens/login_screen.dart'; // We will create this screen next

// --- Configuration ---
// Set to true to bypass login during development/testing
const bool DISABLE_LOGIN_FOR_TESTING = false;
// --- End Configuration ---

void main() {
  runApp(
    // Wrap the entire app with ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => AppState(), // Create an instance of AppState
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recycling Scanner', // Updated title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), // Use a relevant color
        useMaterial3: true,
      ),
      // Use Consumer to decide the initial screen
      home: Consumer<AppState>(
        builder: (context, appState, child) {
          if (DISABLE_LOGIN_FOR_TESTING || appState.isLoggedIn) {
            // If testing or logged in, show the main app structure
            return const AppShell();
          } else {
            // Otherwise, show the login screen
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

// AppShell remains the same as you provided initially
class AppShell extends StatefulWidget {
  const AppShell({super.key});
   @override
   State<AppShell> createState() => _AppShellState();
 }

 class _AppShellState extends State<AppShell> {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      if (_selectedIndex == index) return;
      setState(() {
        _selectedIndex = index;
      });
    }

     @override
      Widget build(BuildContext context) {

        final List<Widget> widgetOptions = <Widget>[
          HomeScreen(onNavigateToScanner: () => _onItemTapped(1)),
          const ScannerScreen(),
          const HistoryScreen(),
        ];

        // Determine the title based on the selected index (optional)
        String currentTitle = 'Recycling App'; // Default title
        if (_selectedIndex == 0) currentTitle = 'Home';
        if (_selectedIndex == 1) currentTitle = 'Scan Code';
        if (_selectedIndex == 2) currentTitle = 'History';

        return Scaffold(
          // --- Correctly placed AppBar ---
          appBar: AppBar(
            title: Text(currentTitle), // Use dynamic title
            backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Match other screens
            actions: [
              // --- Logout Button ---
              // Only show Logout if NOT testing and the user IS logged in
              if (!DISABLE_LOGIN_FOR_TESTING && Provider.of<AppState>(context).isLoggedIn)
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Logout',
                  onPressed: () {
                    // Call the logout method from AppState
                    Provider.of<AppState>(context, listen: false).logoutUser();
                  },
                ),
              // --- End Logout Button ---
            ],
          ), // <--- IMPORTANT: Comma after the AppBar definition

          // --- Body ---
          body: Center(
            child: widgetOptions.elementAt(_selectedIndex),
          ), // <--- Comma after the body (good practice)

          // --- BottomNavigationBar ---
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green, // Match theme
            onTap: _onItemTapped,
          ),
          // --- End BottomNavigationBar ---

        ); // --- End of Scaffold ---
      }
 }