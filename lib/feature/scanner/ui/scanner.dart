import 'package:cd_organizer/feature/scanner/application/scanner_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    FlutterBarcodeScanner.scanBarcode(
      'red',
      'cancel'.tr(),
      true,
      ScanMode.BARCODE,
    ).then(
        (code) => context.read<ScannerBloc>().add(ScannerScanCodeEvent(code)));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () async => {
            await FlutterBarcodeScanner.scanBarcode(
              'red',
              'cancel'.tr(),
              true,
              ScanMode.BARCODE,
            ).then((code) =>
                context.read<ScannerBloc>().add(ScannerScanCodeEvent(code)))
          },
          color: Theme.of(context).colorScheme.primary,
          minWidth: 16,
          height: 16,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                Text(
                  'scan',
                  style: Theme.of(context).textTheme.labelLarge?.apply(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ).tr(),
              ],
            ),
          ),
        ),
        const Divider(),
        TextField(
          controller: controller,
        ),
        MaterialButton(
          onPressed: () => {
            context
                .read<ScannerBloc>()
                .add(ScannerSearchAlbumEvent(controller.text))
          },
          color: Theme.of(context).colorScheme.primary,
          minWidth: 16,
          height: 16,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                Text(
                  'search',
                  style: Theme.of(context).textTheme.labelLarge?.apply(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ).tr(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
