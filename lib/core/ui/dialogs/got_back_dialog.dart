import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/feature/details/application/detail_bloc.dart';

Future showGotBackDialog(
  BuildContext context,
) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('give_back').tr(),
        content: const Text('got_back_dialog').tr(),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx, 'cancel'),
            child: const Text('cancel').tr(),
          ),
          FilledButton(
            onPressed: () {
              context.read<DetailBloc>().add(
                    const DetailGotBackEvent(),
                  );
              Navigator.pop(ctx, 'yes');
            },
            child: const Text('yes').tr(),
          ),
        ],
      );
    },
  );
}
