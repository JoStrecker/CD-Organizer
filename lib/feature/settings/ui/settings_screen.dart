import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/core/ui/snack_bars.dart';
import 'package:music_collection/feature/loading/ui/loading_screen.dart';
import 'package:music_collection/feature/settings/application/settings_bloc.dart';
import 'package:music_collection/feature/settings/ui/widgets/color_picker.dart';
import 'package:music_collection/injection_container.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                  top: 32, left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state.usesMaterialYou
                      ? Container()
                      : ColorPicker(color: state.color),
                  if (!kIsWeb)
                    Row(
                      children: [
                        Expanded(
                          child: const Text('send_notifications').tr(),
                        ),
                        Switch(
                          value: state.sendNotifications,
                          onChanged: (change) =>
                              context.read<SettingsBloc>().add(
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
                    ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  const Center(
                    child: Text(
                      '©2023 Johannes Strecker',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'IBM Plex Mono',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: InkWell(
                      child: const Text(
                        'Data provided by discogs.com',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'IBM Plex Mono',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => launchUrlString('https://www.discogs.com/developers'),
                    ),
                  ),
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
