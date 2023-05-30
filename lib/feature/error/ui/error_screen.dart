import 'package:music_collection/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  final String? message;
  final String? buttonLabel;
  final Function()? buttonFunction;

  const ErrorScreen({
    super.key,
    this.error,
    this.message,
    this.buttonLabel,
    this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Lottie.asset(Assets.lottiesErrorAnim)),
          Text(message ?? ''),
        ],
      ),
    );
  }
}
