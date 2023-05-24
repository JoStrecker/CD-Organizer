import 'package:easy_localization/easy_localization.dart';
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

    return WillPopScope(
      onWillPop: () async {
        cameraController.dispose();
        context.pop();
        return false;
      },
      child: Stack(
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
              tooltip: 'toggle_flash'.tr(),
              child: const Icon(Icons.flash_on),
              onPressed: () => cameraController.toggleTorch(),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            child: FloatingActionButton(
              tooltip: 'switch_camera'.tr(),
              child: const Icon(Icons.cameraswitch),
              onPressed: () => cameraController.switchCamera(),
            ),
          ),
          Positioned(
            top: 16,
            left: 8,
            child: IconButton(
              tooltip: 'go_back'.tr(),
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                cameraController.dispose();
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
