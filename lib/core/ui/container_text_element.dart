import 'package:flutter/material.dart';

class ContainerTextElement extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? textColor;

  const ContainerTextElement({super.key, required this.text, required this.icon, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: textColor,
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.apply(
                  color: textColor,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
