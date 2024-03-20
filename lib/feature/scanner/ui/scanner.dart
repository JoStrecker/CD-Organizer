import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_collection/core/route_info.dart';
import 'package:music_collection/core/ui/dismiss_keyboard.dart';
import 'package:music_collection/core/ui/music_search_bar.dart';
import 'package:music_collection/feature/scanner/application/scanner_bloc.dart';

class Scanner extends StatelessWidget {
  final bool autofocus;
  final bool wishlist;

  const Scanner({
    super.key,
    required this.autofocus,
    required this.wishlist,
  });

  @override
  Widget build(BuildContext context) {
    void barcodeDetect(String? code) {
      context.read<ScannerBloc>().add(ScannerScanCodeEvent(code ?? ''));
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
                child: MusicSearchBar(
                  onSubmitted: (query) => context
                      .read<ScannerBloc>()
                      .add(ScannerSearchAlbumEvent(query)),
                  onClear: () {
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
                tooltip: 'scan_code'.tr(),
                onPressed: () async => context.pushNamed(
                  wishlist
                      ? RouteInfo.wishBarcodeReader.name
                      : RouteInfo.barcodeReader.name,
                  extra: barcodeDetect,
                ),
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
