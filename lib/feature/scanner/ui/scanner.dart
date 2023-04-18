import 'package:cd_organizer/core/ui/dismiss_keyboard.dart';
import 'package:cd_organizer/feature/scanner/application/scanner_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Scanner extends StatelessWidget {
  final String? search;

  const Scanner({super.key, this.search});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: search);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          onSubmitted: (query) =>
              {context.read<ScannerBloc>().add(ScannerSearchAlbumEvent(query))},
          controller: controller,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'search'.tr(),
            suffixIcon: IconButton(
              onPressed: () {
                controller.clear;
                unfocusCurrWidget(context);
              },
              icon: const Icon(Icons.clear),
            ),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        FilledButton(
          onPressed: () async => {
            await FlutterBarcodeScanner.scanBarcode(
              'red',
              'cancel'.tr(),
              true,
              ScanMode.BARCODE,
            ).then((code) =>
                context.read<ScannerBloc>().add(ScannerScanCodeEvent(code)))
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.qr_code_scanner),
              const Text('scan').tr(),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
