import 'package:music_collection/core/ui/dismiss_keyboard.dart';
import 'package:music_collection/core/ui/search_bar.dart';
import 'package:music_collection/feature/scanner/application/scanner_bloc.dart';
import 'package:music_collection/feature/scanner/ui/barcode_scanner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Scanner extends StatelessWidget {
  final bool autofocus;

  const Scanner({super.key, required this.autofocus});

  @override
  Widget build(BuildContext context) {
    validateCode(String code) {
      context.read<ScannerBloc>().add(ScannerScanCodeEvent(code));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: SearchBar(
                  onSubmitted: (query) => context
                      .read<ScannerBloc>()
                      .add(ScannerSearchAlbumEvent(query)),
                  onPressed: () {
                    context
                        .read<ScannerBloc>()
                        .add(const ScannerClearSearchEvent());
                    unfocusCurrWidget(context);
                  },
                  controller: (context.read<ScannerBloc>().state
                          as ScannerControlledState)
                      .controller,
                  autofocus: autofocus,
                ),
              ),
              IconButton(
                onPressed: () async => {
                  await FlutterBarcodeScanner.scanBarcode(
                    'red',
                    'cancel'.tr(),
                    true,
                    ScanMode.BARCODE,
                  ).then(
                    (code) => context
                        .read<ScannerBloc>()
                        .add(ScannerScanCodeEvent(code)),
                  )
                },
                icon: const Icon(Icons.camera_alt),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
