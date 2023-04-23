import 'package:cd_organizer/core/ui/back_bar.dart';
import 'package:cd_organizer/feature/empty/ui/empty_screen.dart';
import 'package:cd_organizer/feature/error/ui/error_screen.dart';
import 'package:cd_organizer/feature/loading/ui/loading_screen.dart';
import 'package:cd_organizer/feature/results/ui/result_screen.dart';
import 'package:cd_organizer/feature/scanner/application/scanner_bloc.dart';
import 'package:cd_organizer/feature/scanner/ui/scanner.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScannerScreen extends StatelessWidget {
  final bool wishlist;

  const ScannerScreen({super.key, required this.wishlist});

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
                  const Scanner(),
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
                  const Scanner(),
                  Expanded(
                    child: ResultScreen(
                      releases: state.results,
                      wishlist: wishlist,
                    ),
                  ),
                ],
              );
            } else if (state is ScannerErrorState) {
              return Column(
                children: [
                  const Scanner(),
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
