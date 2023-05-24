import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_collection/feature/details/application/detail_bloc.dart';

Future showAddToCollectionDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('addToCollection').tr(),
        content: const Text('addCollectionDialog').tr(),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx, 'cancel'),
            child: const Text('cancel').tr(),
          ),
          FilledButton(
            onPressed: () {
              context.read<DetailBloc>().add(const DetailAddCollectionEvent());
              Navigator.pop(ctx, 'yes');
              context.pop(true);
            },
            child: const Text('yes').tr(),
          ),
        ],
      );
    },
  );
}
