import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
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
      child: FractionallySizedBox(
        heightFactor: 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Lottie.asset(Assets.lottiesErrorAnim)),
            Text(message ?? error?.toString() ?? ''),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: context.pop,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back_ios_new),
                      const SizedBox(width: 4),
                      const Text('go_back').tr()
                    ],
                  ),
                ),
                if (buttonFunction != null) const SizedBox(width: 4),
                if (buttonFunction != null)
                  FilledButton(
                    onPressed: buttonFunction,
                    child: buttonLabel != null
                        ? Text(buttonLabel!)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.refresh),
                              const SizedBox(width: 4),
                              const Text('reload').tr()
                            ],
                          ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
