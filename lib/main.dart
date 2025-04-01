import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // Import the scanner package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner App', // Changed title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScannerPage(), // Point to our new ScannerPage
    );
  }
}

// New StatefulWidget for our scanner page
class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  // Controller for the mobile scanner
  final MobileScannerController _scannerController = MobileScannerController(
      // Optional: You can configure settings like torch, camera direction here
      // facing: CameraFacing.back,
      // torchEnabled: false,
      // detectionSpeed: DetectionSpeed.normal, // Faster detection, more battery
      // detectionTimeoutMs: 250, // Timeout for duplicate detections
      returnImage: false // We don't need the image data, just the barcode
      );

  // Variable to hold the scanned result
  String? _scannedBarcode;
  Stream<BarcodeCapture>? barcodeCaptureStream;

  @override
  void initState() {
    super.initState();
    // Start listening to the barcode stream immediately
    barcodeCaptureStream = _scannerController.barcodes;
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Scan Barcode/QR Code'),
        actions: [
          // Simplified Flash Toggle Button
          IconButton(
            color: Colors.white, // Or adjust color as needed
            icon: const Icon(Icons.flash_on), // Use a static icon
            tooltip: 'Toggle Flash', // Tooltip is helpful
            iconSize: 32.0,
            onPressed: () => _scannerController.toggleTorch(), // Action remains the same
          ),
          // Simplified Camera Switch Button
          IconButton(
            color: Colors.white, // Or adjust color as needed
            icon: const Icon(Icons.switch_camera), // Use a static icon
            tooltip: 'Switch Camera', // Tooltip is helpful
            iconSize: 32.0,
            onPressed: () => _scannerController.switchCamera(), // Action remains the same
          ),
        ],
      ),
      body: Column( // Use a Column to stack scanner and result text
        children: [
          Expanded( // Scanner view should take up most space
            flex: 4, // Give scanner more space
            child: Stack( // Use Stack for overlay effects if needed later
              children: [
                MobileScanner(
                  controller: _scannerController,
                  // The new way to listen for barcodes using the controller's stream
                  onDetect: (capture) {
                    // This callback might still fire rapidly.
                    // Consider adding throttling/debouncing logic here if needed
                    // to prevent processing the same code multiple times per second.
                    final List<Barcode> barcodes = capture.barcodes;
                    // final Uint8List? image = capture.image; // We disabled this with returnImage: false

                    if (barcodes.isNotEmpty) {
                      final String? code = barcodes.first.rawValue;
                      if (code != null && code != _scannedBarcode) { // Check if it's a new code
                        print('Barcode detected! Raw value: $code');
                        setState(() {
                          _scannedBarcode = code;
                        });
                        // --- TODO: Add code here to send '_scannedBarcode' to your API ---
                      }
                    }
                  },
                  /* // Old onDetect (might be deprecated in future versions)
                  onDetect: (barcode, args) {
                     if (barcode.rawValue == null) {
                       debugPrint('Failed to scan Barcode');
                     } else {
                       final String code = barcode.rawValue!;
                       // Only update state if it's a *new* code to avoid rapid rebuilds
                       if (code != _scannedBarcode) {
                          print('Barcode found! $code');
                          setState(() {
                           _scannedBarcode = code;
                         });
                         // --- TODO: Add code here to send '_scannedBarcode' to your API ---
                       }
                     }
                   },
                   */
                ),
                // Optional: Add a viewfinder overlay widget here if desired
                // Center(child: CustomPaint(painter: ScannerOverlayPainter())),
              ],
            ),
          ),
          Expanded( // Result display area
            flex: 1, // Give result less space
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _scannedBarcode == null
                      ? 'Scan a code'
                      : 'Scanned: $_scannedBarcode',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Example for a simple overlay painter (Optional)
/*
class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final rectWidth = size.width * 0.8;
    final rectHeight = size.height * 0.4;
    final left = (size.width - rectWidth) / 2;
    final top = (size.height - rectHeight) / 2;

    final rect = Rect.fromLTWH(left, top, rectWidth, rectHeight);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
*/