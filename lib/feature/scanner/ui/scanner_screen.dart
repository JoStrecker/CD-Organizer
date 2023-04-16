import 'package:cd_organizer/feature/loading/ui/loading_screen.dart';
import 'package:cd_organizer/feature/results/ui/result_screen.dart';
import 'package:cd_organizer/feature/scanner/application/scanner_bloc.dart';
import 'package:cd_organizer/feature/scanner/ui/scanner.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScannerBloc>(
      create: (context) => sl<ScannerBloc>(),
      child: BlocBuilder<ScannerBloc, ScannerState>(
        builder: (context, state) {
          if (state is ScannerInitialState) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Scanner(),
            );
          } else if (state is ScannerLoadingState) {
            return const LoadingScreen();
          } else if (state is ScannerResultState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  Scanner(search: state.search),
                  Expanded(
                    child: ResultScreen(
                      releases: state.results,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
