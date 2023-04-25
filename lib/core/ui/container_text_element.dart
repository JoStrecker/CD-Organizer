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
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: (maxLines ?? 1) > 1
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          const SizedBox(
            width: 4,
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
      ),
    );
  }
}
