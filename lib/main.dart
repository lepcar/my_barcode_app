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

  // List of the widgets (Screens) to display in the body
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ScannerScreen(),
    HistoryScreen(),
  ];

  // Function called when a tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body displays the widget from _widgetOptions based on the selected index
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // Bottom Navigation Bar setup
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
        currentIndex: _selectedIndex, // Highlights the current tab
        selectedItemColor: Colors.deepPurple, // Color for selected tab
        onTap: _onItemTapped, // Function to call when a tab is tapped
      ),
    );
  }
}