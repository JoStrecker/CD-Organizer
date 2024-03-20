import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MusicSearchBar extends StatelessWidget {
  final Function(String) onSubmitted;
  final void Function() onClear;
  final TextEditingController controller;
  final bool? autofocus;

  const MusicSearchBar({
    super.key,
    required this.onSubmitted,
    required this.onClear,
    required this.controller,
    this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: Theme.of(context).colorScheme.surfaceVariant,
      elevation: 8,
      borderRadius: BorderRadius.circular(24),
      child: TextField(
        onSubmitted: onSubmitted,
//        onChanged: (query) {
//          Debouncer(duration: const Duration(milliseconds: 1500)).run(() {
//            onSubmitted(query);
//          });
//        },
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.search,
        autofocus: autofocus ?? false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'search'.tr(),
          suffixIcon: IconButton(
            tooltip: 'clear'.tr(),
            onPressed: onClear,
            icon: const Icon(Icons.clear),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
