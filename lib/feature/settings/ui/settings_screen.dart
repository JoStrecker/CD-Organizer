import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/feature/loading/ui/loading_screen.dart';
import 'package:music_collection/feature/settings/application/settings_bloc.dart';
import 'package:music_collection/feature/settings/ui/widgets/color_picker.dart';
import 'package:music_collection/feature/settings/ui/widgets/copyright.dart';
import 'package:music_collection/feature/settings/ui/widgets/notification_settings.dart';
import 'package:music_collection/injection_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => sl<SettingsBloc>()..add(const SettingsLoadEvent()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoadedState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 32,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!state.usesMaterialYou) ColorPicker(color: state.color),
                  if (!kIsWeb)
                    NotificationSettings(
                      state.sendNotifications,
                    ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  const Copyright(),
                ],
              ),
            );
          } else if (state is SettingsLoadingState) {
            return const LoadingScreen();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
