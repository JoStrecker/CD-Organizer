import 'package:music_collection/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
