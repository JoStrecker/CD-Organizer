part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {
  const SettingsEvent();
}

class SettingsLoadEvent extends SettingsEvent {
  const SettingsLoadEvent();
}

class SettingsSaveChangesEvent extends SettingsEvent {
  final Color newColor;

  const SettingsSaveChangesEvent(this.newColor);
}
