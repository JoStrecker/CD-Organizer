import 'package:flutter/material.dart';

class ContainerTextElement extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? textColor;
  final int? maxLines;

  const ContainerTextElement({
    super.key,
    required this.text,
    required this.icon,
    this.textColor,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: (maxLines ?? 1) > 1
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 4,
            right: 4,
          ),
          child: Icon(
            icon,
            color: textColor,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.apply(
                  color: textColor,
                ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
