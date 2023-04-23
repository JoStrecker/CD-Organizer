import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackBar extends StatelessWidget {
  final BuildContext ctx;
  final String text;

  const BackBar({super.key, required this.ctx, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              ctx.pop(true);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 4),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
