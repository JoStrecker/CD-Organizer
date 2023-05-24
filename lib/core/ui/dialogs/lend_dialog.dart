import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/feature/details/application/detail_bloc.dart';

Future showLendDialog(BuildContext context) {
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
              OutlinedButton(
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
