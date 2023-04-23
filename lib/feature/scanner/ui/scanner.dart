import 'package:cd_organizer/core/ui/dismiss_keyboard.dart';
import 'package:cd_organizer/feature/scanner/application/scanner_bloc.dart';
import 'package:cd_organizer/feature/scanner/ui/barcode_scanner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Scanner extends StatelessWidget {
  const Scanner({super.key});

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
                child: TextField(
                  onSubmitted: (query) => context
                      .read<ScannerBloc>()
                      .add(ScannerSearchAlbumEvent(query)),
                  controller: (context.read<ScannerBloc>().state
                          as ScannerControlledState)
                      .controller,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    fillColor: Theme.of(context).colorScheme.surfaceVariant,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    hintText: 'search'.tr(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        context
                            .read<ScannerBloc>()
                            .add(const ScannerClearSearchEvent());
                        unfocusCurrWidget(context);
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
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
