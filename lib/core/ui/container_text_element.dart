import 'package:flutter/material.dart';

class ContainerTextElement extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContainerTextElement({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.apply(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
