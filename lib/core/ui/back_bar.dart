import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackBar extends StatelessWidget {
  final BuildContext ctx;
  final String text;

  const BackBar({
    super.key,
    required this.ctx,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            tooltip: 'go_back'.tr(),
            onPressed: () {
              ctx.pop(true);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.headlineLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
