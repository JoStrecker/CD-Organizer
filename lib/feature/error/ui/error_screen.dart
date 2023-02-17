import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  final String? message;
  final String? buttonLabel;
  final Function()? buttonFunction;

  const ErrorScreen(
      {super.key,
        this.error,
        this.message,
        this.buttonLabel,
        this.buttonFunction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Error Screen'),
            Text(message ?? ''),
          ],
        ),
      ),
    );
  }
}