import 'package:cd_organizer/feature/details/application/detail_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future deleteDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('delete').tr(),
      content: const Text('wantToDelete').tr(),
      actions: [
        FilledButton.tonal(
          onPressed: () => Navigator.pop(ctx, 'cancel'),
          child: const Text('cancel').tr(),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(ctx, 'yes');
            context.read<DetailBloc>().add(const DetailDeleteEvent());
            context.pop(true);
          },
          child: const Text('yes').tr(),
        ),
      ],
    ),
  );
}

Future lendDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) {
      TextEditingController controller = TextEditingController();
      return SimpleDialog(
        contentPadding: const EdgeInsets.only(
          left: 24,
          top: 12,
          right: 24,
          bottom: 24,
        ),
        title: const Text('lend').tr(),
        children: [
          TextField(
            onSubmitted: (query) {
              if (controller.text.isNotEmpty) {
                context
                    .read<DetailBloc>()
                    .add(DetailLendEvent(controller.text));
              }
              Navigator.pop(ctx, 'lend');
            },
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'name'.tr(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton.tonal(
                onPressed: () => Navigator.pop(ctx, 'cancel'),
                child: const Text('cancel').tr(),
              ),
              const SizedBox(
                width: 8,
              ),
              FilledButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    context
                        .read<DetailBloc>()
                        .add(DetailLendEvent(controller.text));
                  }
                  Navigator.pop(ctx, 'lend');
                },
                child: const Text('lend').tr(),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future gotBackDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('giveBack').tr(),
        content: const Text('gotBackDialog').tr(),
        actions: [
          FilledButton.tonal(
            onPressed: () => Navigator.pop(ctx, 'cancel'),
            child: const Text('cancel').tr(),
          ),
          FilledButton(
            onPressed: () {
              context.read<DetailBloc>().add(const DetailGotBackEvent());
              Navigator.pop(ctx, 'yes');
            },
            child: const Text('yes').tr(),
          ),
        ],
      );
    },
  );
}

Future addCollectionDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('addToCollection').tr(),
        content: const Text('addCollectionDialog').tr(),
        actions: [
          FilledButton.tonal(
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
