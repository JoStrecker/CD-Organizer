part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {
  const SettingsState();
}

class SettingsInitialState extends SettingsState {
  const SettingsInitialState();
}

class SettingsLoadingState extends SettingsState {
  const SettingsLoadingState();
}

class SettingsLoadedState extends SettingsState {
  final Color color;
  final bool usesMaterialYou;
  final bool sendNotifications;

  const SettingsLoadedState({
    required this.color,
    required this.usesMaterialYou,
    required this.sendNotifications,
  });
}
