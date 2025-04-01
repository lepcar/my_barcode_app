import 'package:flutter/material.dart';
import 'package:my_barcode_app/screens/home_screen.dart';     // Import screen
import 'package:my_barcode_app/screens/scanner_screen.dart';  // Import screen
import 'package:my_barcode_app/screens/history_screen.dart'; // Import screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppShell(), // Use AppShell as the main structure
    );
  }
}

// This Widget manages the main app structure including the BottomNavBar
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0; // Index for the currently selected tab

  // Function called when a tab is tapped
  void _onItemTapped(int index) {
    // Prevent navigation if already on the target screen
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> widgetOptions = <Widget>[
      HomeScreen(onNavigateToScanner: () => _onItemTapped(1)), // Pass callback
      const ScannerScreen(),
      const HistoryScreen(),
    ];

    return Scaffold(
      // Use the locally defined list
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // ... (items remain the same) ...
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
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped, // Use the method directly here
      ),
    );
  }
}