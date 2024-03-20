import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_collection/generated/assets.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(Assets.lottiesLoadingAnim),
    );
  }
}
