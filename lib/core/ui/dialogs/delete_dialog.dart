import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future showDeleteDialog(
  BuildContext context,
  Function deleteCallback, {
  bool pop = true,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('delete').tr(),
      content: const Text('wantToDelete').tr(),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(ctx, 'cancel'),
          child: const Text('cancel').tr(),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(ctx, 'yes');
            deleteCallback();
            if (pop) {
              context.pop(true);
            }
          },
          child: const Text('yes').tr(),
        ),
      ],
    ),
  );
}
