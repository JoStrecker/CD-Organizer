import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

Future<String?> showBarCodeScannerDialog({
  required BuildContext context,
  TransitionBuilder? builder,
  required String? Function(String rawCode) validator,
  bool optionForCode = false,
}) async {
  Widget dialog = MobileScanner(
    onDetect: (capture) {
      final List<Barcode> barcodes = capture.barcodes;
      for (final barcode in barcodes) {
        validator(barcode.rawValue ?? '');
        Navigator.pop(context);
      }
    },
  );
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}
