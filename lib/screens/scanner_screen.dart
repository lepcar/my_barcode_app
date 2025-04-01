import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// Removed `main` and `MyApp`

// Renamed class
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  // Updated State reference
  State<ScannerScreen> createState() => _ScannerScreenState();
}

// Renamed class
class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController(
    returnImage: false,
  );
  String? _scannedBarcode;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  // --- Function to clear the last scan ---
  void _clearLastScan() {
    setState(() {
      _scannedBarcode = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Scan Barcode/QR Code'),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.onPrimary, // Use theme color
            icon: const Icon(Icons.flash_on),
            tooltip: 'Toggle Flash',
            iconSize: 32.0,
            onPressed: () => _scannerController.toggleTorch(),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.onPrimary, // Use theme color
            icon: const Icon(Icons.switch_camera),
            tooltip: 'Switch Camera',
            iconSize: 32.0,
            onPressed: () => _scannerController.switchCamera(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3, // Adjusted flex
            child: Stack(
              children: [
                MobileScanner(
                  controller: _scannerController,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty) {
                      final String? code = barcodes.first.rawValue;
                      if (code != null && code.isNotEmpty && code != _scannedBarcode) {
                        // Check code is not empty string "" before updating state
                        print('Barcode detected! Raw value: $code');
                        setState(() {
                          _scannedBarcode = code;
                        });
                        // --- TODO: Add code here to send '_scannedBarcode' to your API ---
                      }
                    }
                  },
                ),
                // Optional: Add viewfinder overlay here if desired
              ],
            ),
          ),
          Expanded( // Combined result and clear button area
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column( // Use column for text and button
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( // Result Text
                      _scannedBarcode == null
                          ? 'Scan a code'
                          : 'Scanned: $_scannedBarcode',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10), // Spacing
                    // --- Clear Button ---
                    if (_scannedBarcode != null) // Only show if something is scanned
                      ElevatedButton.icon(
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        onPressed: _clearLastScan, // Call the clear function
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      ),
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}