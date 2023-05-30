import 'package:music_collection/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyScreen extends StatelessWidget {
  final Widget? child;

  const EmptyScreen({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(Assets.lottiesEmptyAnim),
            child ?? Container(),
          ],
        ),
      ),
    );
  }
}
