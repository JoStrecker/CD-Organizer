import 'package:cd_organizer/ui/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
