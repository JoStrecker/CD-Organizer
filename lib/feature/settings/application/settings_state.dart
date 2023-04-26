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

  const SettingsLoadedState(this.color);
}
