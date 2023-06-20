import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future showLocationDialog(
  BuildContext context,
  String? location,
  void Function(String text) locationCallback,
) {
  return showDialog(
    context: context,
    builder: (ctx) {
      TextEditingController controller = TextEditingController(
        text: location,
      );
      return SimpleDialog(
        contentPadding: const EdgeInsets.only(
          left: 24,
          top: 12,
          right: 24,
          bottom: 24,
        ),
        title: location == null
            ? const Text('add_location').tr()
            : const Text('change_location').tr(),
        children: [
          TextField(
            onSubmitted: (query) {
              if (controller.text.isNotEmpty) {
                locationCallback(controller.text);
              }
              Navigator.pop(ctx, 'location');
            },
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'location'.tr(),
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
                    locationCallback(controller.text);
                  }
                  Navigator.pop(ctx, 'location');
                },
                child: const Text('save').tr(),
              ),
            ],
          ),
        ],
      );
    },
  );
}
