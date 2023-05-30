import 'package:music_collection/core/ui/back_bar.dart';
import 'package:music_collection/feature/empty/ui/empty_screen.dart';
import 'package:music_collection/feature/error/ui/error_screen.dart';
import 'package:music_collection/feature/loading/ui/loading_screen.dart';
import 'package:music_collection/feature/results/ui/result_screen.dart';
import 'package:music_collection/feature/scanner/application/scanner_bloc.dart';
import 'package:music_collection/feature/scanner/ui/scanner.dart';
import 'package:music_collection/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScannerScreen extends StatelessWidget {
  final bool wishlist;

  const ScannerScreen({
    super.key,
    required this.wishlist,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop(true);
        return false;
      },
      child: BlocProvider<ScannerBloc>(
        create: (context) => sl<ScannerBloc>()..add(const ScannerLoadEvent()),
        child: BlocBuilder<ScannerBloc, ScannerState>(
          builder: (context, state) {
            if (state is ScannerLoadedState) {
              return Column(
                children: [
                  BackBar(ctx: context, text: 'addAlbum'.tr()),
                  const SizedBox(
                    height: 8,
                  ),
                  Scanner(
                    autofocus: true,
                    wishlist: wishlist,
                  ),
                  Expanded(
                    child: EmptyScreen(
                      child: const Text(
                        'trySearching',
                        textAlign: TextAlign.center,
                      ).tr(),
                    ),
                  ),
                ],
              );
            } else if (state is ScannerLoadingState) {
              return const LoadingScreen();
            } else if (state is ScannerResultState) {
              return Column(
                children: [
                  BackBar(ctx: context, text: 'addAlbum'.tr()),
                  const SizedBox(
                    height: 8,
                  ),
                  Scanner(
                    autofocus: false,
                    wishlist: wishlist,
                  ),
                  Expanded(
                    child: ResultScreen(
                      releases: state.results,
                      wishlist: wishlist,
                      query: state.controller.text,
                      pageCount: state.pageCount,
                    ),
                  ),
                ],
              );
            } else if (state is ScannerErrorState) {
              return Column(
                children: [
                  BackBar(ctx: context, text: 'addAlbum'.tr()),
                  const SizedBox(
                    height: 8,
                  ),
                  Scanner(
                    autofocus: true,
                    wishlist: wishlist,
                  ),
                  Expanded(
                    child: ErrorScreen(
                      message: state.errorMessage,
                    ),
                  ),
                ],
              );
            } else {
              return const EmptyScreen();
            }
          },
        ),
      ),
    );
  }
}
