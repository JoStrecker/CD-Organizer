import 'package:cd_organizer/feature/navigation/ui/navigation.dart';
import 'package:flutter/material.dart';

class Framework extends StatelessWidget {
  final Widget child;

  const Framework({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const Navigation(),
    );
  }
}
