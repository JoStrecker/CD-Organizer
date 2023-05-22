import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanner extends StatelessWidget {
  final void Function(String?) barcodeDetect;

  const BarcodeScanner({
    super.key,
    required this.barcodeDetect,
  });

  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: [BarcodeFormat.ean13],
    );

    return Stack(
      children: [
        MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            barcodeDetect(capture.barcodes.first.rawValue);
            context.pop();
          },
        ),
        Positioned(
          bottom: 32,
          right: 32,
          child: FloatingActionButton(
            child: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
        ),
        Positioned(
          bottom: 32,
          left: 32,
          child: FloatingActionButton(
            child: const Icon(Icons.cameraswitch),
            onPressed: () => cameraController.switchCamera(),
          ),
        ),
        Positioned(
          top: 32,
          left: 32,
          child: FloatingActionButton(
            child: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}
