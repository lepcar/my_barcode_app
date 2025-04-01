import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView( // Use ListView for scrollable history
        children: const [
          // Placeholder List Tiles - Replace with actual data later
          ListTile(
            leading: Icon(Icons.barcode_reader),
            title: Text('123456789012'),
            subtitle: Text('Scanned on: 2023-10-27 10:00 AM'),
          ),
          ListTile(
            leading: Icon(Icons.qr_code_scanner),
            title: Text('HTTPS://EXAMPLE.COM'),
            subtitle: Text('Scanned on: 2023-10-27 10:05 AM'),
          ),
          ListTile(
            leading: Icon(Icons.barcode_reader),
            title: Text('987654321098'),
            subtitle: Text('Scanned on: 2023-10-27 10:10 AM'),
          ),
        ],
      ),
    );
  }
}