import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSubmitted;
  final void Function() onPressed;
  final TextEditingController controller;
  final bool? autofocus;

  const SearchBar({
    super.key,
    required this.onSubmitted,
    required this.onPressed,
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
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.search,
        autofocus: autofocus ?? false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'search'.tr(),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.clear),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
