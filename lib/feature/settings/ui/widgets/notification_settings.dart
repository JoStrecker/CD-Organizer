import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/core/ui/snack_bars.dart';
import 'package:music_collection/feature/settings/application/settings_bloc.dart';

class NotificationSettings extends StatelessWidget {
  final bool sendNotifications;

  const NotificationSettings(
    this.sendNotifications, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: const Text('send_notifications').tr(),
        ),
        Switch(
          value: sendNotifications,
          onChanged: (change) => context.read<SettingsBloc>().add(
                SettingsChangeNotificationsEvent(
                  (message) => showSnackBar(
                    message,
                    context,
                  ),
                  change,
                ),
              ),
        ),
      ],
    );
  }
}
