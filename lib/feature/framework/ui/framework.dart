import 'package:flutter/material.dart';
import 'package:music_collection/feature/navigation/ui/navigation.dart';

class Framework extends StatelessWidget {
  final Widget child;

  const Framework({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: child,
          ),
        ),
        bottomNavigationBar: const Navigation(),
      ),
    );
  }
}
